(in-package #:botanic)

(defun get-prices (filename)
  (remove-if #'(lambda (z)
                 (string= "" (car z)))
             (mapcar #'(lambda (x)
                         (butlast
                          (cdr
                           (mapcar #'(lambda (y)
                                       (string-trim '(#\Space #\Newline #\t) y))
                                   (split-sequence:split-sequence #\| x)))))
                     (remove-if #'(lambda (x)
                                    (string= x ""))
                                (cddr (split-sequence:split-sequence
                                       #\Newline
                                       (alexandria:read-file-into-string (path filename))))))))

;; каталог растений
(defparameter *prices-flower* (get-prices (path "catalog/catalog-flower/prices-flower.txt")))

;; цветущие(+)
(defun blooming ()
  (remove-if-not #'(lambda (x)
                     (string= "+" (cadddr x)))
                 *prices-flower*))

;; до метра(>99)
(defun below_meter ()
  (remove-if #'(lambda (x)
                 (let ((size (parse-integer (cadr x) :junk-allowed t)))
                   (if (null size)
                       t
                       (> size 99))))
             *prices-flower*))

;; от метра(<99)
(defun above_meter ()
  (remove-if #'(lambda (x)
                 (let ((size (parse-integer (cadr x) :junk-allowed t)))
                   (if (null size)
                       t
                       (< size 99))))
             *prices-flower*))

;; каталог кашпо
(defparameter *prices-kashpo*  (get-prices (path "catalog/catalog-kashpo/prices-kashpo.txt")))




;; ORG-FND-MACRO

(defmacro find-command (str body &optional (replace '(setf line "ℕ")))
  `(when (equal 0 (search ,str line))
     (let ((tail (handler-case (subseq line (+ 1 (length ,str)))
                   (SB-KERNEL:BOUNDING-INDICES-BAD-ERROR () ,str))))
       ,body
       ,replace)))

(defmacro find-directive (directive)
  `(find-command ,directive (setf (getf directives (intern (string-upcase (subseq ,directive 1)) :keyword))
                                  (string-trim '(#\  #\tab #\Newline) tail))))


;; DBG-MACRO

(defmacro bprint (var)
  `(subseq (with-output-to-string (*standard-output*)  (pprint ,var)) 1))

(defmacro err (var)
  `(error (format nil "ERR:[~A]" (bprint ,var))))

(defmacro do-hash ((ht &optional (v 'v) (k 'k)) &body body)
  `(loop :for ,v :being :the :hash-values :in ,ht :using (hash-key ,k) :do
      ,@body))

(defmacro do-hash-collect ((ht &optional (v 'v) (k 'k)) &body body)
  `(loop :for ,v :being :the :hash-values :in ,ht :using (hash-key ,k) :collect
      ,@body))

(defmacro append-link (lst elt)
  `(setf ,lst (remove-duplicates (append ,lst (list ,elt)))))


;; GET-ORG-SECT

(defun get-org-sect (filename)
  (let* ((strings (split-sequence:split-sequence
                   #\NewLine
                   (alexandria:read-file-into-string (path filename))))
         (sections)
         (directives)
         (lines (loop
                   :for line :in strings
                   :for num  :from 0
                   :collect
                   (progn
                     ;; Удаляем директиву -*-
                     (when (search "-*-" line)
                       (setf line "ℕ"))
                     ;; Директивы
                     (find-directive "@title")
                     (find-directive "@category")
                     (find-directive "@sort")
                     ;; *
                     (when (ppcre:scan "\\A\\*+\\s+" line)
                       (let ((cnt 1)) ;; Подcчитаем количество звездочек
                         (loop :for item :across line :do
                            (if (char= #\* item)
                                (incf cnt)
                                (return)))
                         (let ((headline (subseq line cnt)))
                           (push (list cnt headline num) sections)
                           (setf line (format nil "ℙ ~A" (list cnt headline num))))))
                     ;; default
                     line)))
         (end (length lines)))
    (reverse
     (loop :for sect :in sections :collect
        (let* ((start (caddr sect))
               (contents (list (remove-if #'(lambda (line)
                                              (or
                                               (search "ℕ" line)
                                               (search "ℙ" line)))
                                          (subseq lines start end)))))
          (prog1
              (append sect contents)
            (setf end start)))))))


;; entity-metaclass

(defclass entity-class (dao-class)
  ;; Что мне дают слоты метакласса?
  ;; Сюда можно добавлять дополнительную информацию о связанных сущностях и получать ее по
  ;; (linked-entityes (find-class class-name)))
  ((linked-entityes   :initform  nil   :initarg :linked-entityes    :accessor linked-entityes))
  (:documentation "metaclass extend postmodern dao-class"))

;; Определяем, что entity-class является наследником dao-class из postmodern
(defmethod validate-superclass ((class entity-class) (super-class dao-class))
  t)

;; Определяем класс слота, разбирающий дополнительные аргументы
(defclass direct-link-to-slot (standard-direct-slot-definition)
  ((link-to :initarg link-to :reader link-to))
  (:documentation "link to external entity"))

;; Можно/нужно отдельно специфицировать make-instance для direct-link-to-slot? Или это делает initialize-instance?

(defmethod initialize-instance ((class direct-link-to-slot) &rest initargs &key link-to)
  ;; (err link-to)
  (call-next-method)
  )

;; Специфицируем, каким классом слотов будут разбираться слоты с дополнительными аргументами
(defmethod direct-slot-definition-class ((class entity-class) &rest initargs &key link-to &allow-other-keys)
  (declare (ignore initargs))
  (if link-to
      (find-class 'direct-link-to-slot)
      (call-next-method)))


(defmacro def~entity (name &rest tail)
  (let ((inc            (intern (concatenate 'string "INC-"     (symbol-name name) "-ID")))
        (incf-inc       (intern (concatenate 'string "INCF-"    (symbol-name name) "-ID")))
        (init-inc       (intern (concatenate 'string "INIT-"    (symbol-name name) "-ID")))
        (container      (intern (concatenate 'string "*"        (symbol-name name) "*")))
        (count-entity   (intern (concatenate 'string "COUNT-"   (symbol-name name))))
        (make-entity    (intern (concatenate 'string "MAKE-"    (symbol-name name))))
        (all-entity     (intern (concatenate 'string "ALL-"     (symbol-name name))))
        (get-entity     (intern (concatenate 'string "GET-"     (symbol-name name))))
        (find-entity    (intern (concatenate 'string "FIND-"    (symbol-name name)))))
    `(let ((,inc 0))
       ;; incrementor
       (defun ,incf-inc ()
         (incf ,inc))
       ;; incrementor init
       (defun ,init-inc (init-value)
         (setf ,inc init-value))
       ;; container
       (defparameter ,container (make-hash-table :test #'equal))
       ;; container counter
       (defun ,count-entity ()
         (hash-table-count ,container))
       ;; class
       (defclass     ,name ,@tail)
       ;; make-entity
       (defun ,make-entity (&rest initargs)
         (let ((id (,incf-inc)))
           ;; todo: duplicate by id
           ;; todo: duplicate by fields
           (values
            (setf (gethash id ,container)
                  (apply #'make-instance
                         (list* ',name initargs)))
            id)))
       (defun ,all-entity ()
         (do-hash-collect (,container)
           (cons v k)))
       ;; get-entity (by id, typesafe, not-present safe)
       (defun ,get-entity (var)
         (when (typep var 'integer)
           (multiple-value-bind (hash-val present-p)
               (gethash var ,container)
             (unless present-p
               (err 'not-present))
             (setf var hash-val)))
         (unless (typep var ',name)
           (err 'param-user-type-error))
         var)
       ;; find-entity - поиск айдишника по объекту
       (defmethod ,find-entity ((obj ,name))
         (do-hash (,container)
           (when (equal v obj)
             (return k))))
       ;; find-entity - поиск объекта по содержимому его полей
       (defmethod ,find-entity ((func function))
         (let ((rs))
           (mapcar #'(lambda (x)
                       (if (funcall func x)
                           (push x rs)))
                   (,all-entity))
           rs))
       )))


(def~entity org-block ()
  ((name       :col-type string  :initarg :name      :initform ""  :accessor name)
   (content    :col-type string  :initarg :content   :initform nil :accessor content)
   (sub        :col-type string  :initarg :sub       :initform nil  :accessor sub))
  (:metaclass entity-class)
  (:keys name))

(let ((level   1)
      (sects   (get-org-sect "/home/rigidus/repo/toledo/README.org"))
      (parents (list (make-org-block :name "root" :content  "root"))))
  (flet ((dbg (obj level parents)
           (format t "~A (l:~A) вниз ~{~A ~}" (name obj) level
                   (mapcar #'(lambda (x)
                               (format nil "{~A:~A}"
                                       (find-org-block x)
                                       (name x)))
                           parents))))
    (loop :for item :in sects :collect
       (multiple-value-bind (obj id)
           (make-org-block
            :name     (nth 1 item)
            :content  (nth 3 item))
         (format t "~% ~A:[~A] " id (car item))
         (cond ((> (car item) level)
                (push obj parents)
                (setf level (car item))
                (dbg obj level parents)
                (append-link (sub (cadr parents)) obj)
                )
               ((< (car item) level)
                (pop parents)
                (pop parents)
                (push obj parents)
                (setf level (car item))
                (dbg obj level parents)
                (append-link (sub (cadr parents)) obj)
                )
               (t
                (pop parents)
                (push obj parents)
                (setf level (car item))
                (dbg obj level parents)
                (append-link (sub (cadr parents)) obj)
                ))))))

(do-hash (*org-block*)
  (format t "~% ~A : ~A ~A"
          k
          (name v)
          (mapcar #'(lambda (x)
                      (format nil "~A:~A"
                              (find-org-block x)
                              (name x)))
                  (sub v))))

;; Находим элемент Userstory
(let ((userstory-id))
  (do-hash (*org-block*)
    (when (search "Userstory" (name v))
      (setf userstory-id k)))
  ;; Для каждого из подэлементов ищем estimates
  (let ((estimates))
    (defun recursive-find-estimates (elt-id)
      (let ((elt (gethash elt-id *org-block*)))
        (if (search "{" (name elt))
            ;; Нашли, надо разобрать и сохранить
            (print (name elt))
            ;; Не нашли
            2)
        ;; Обрабатываем подэлементы
        (loop :for item :in (sub elt) :do
           (recursive-find-estimates (find-org-block item)))))
    (recursive-find-estimates userstory-id))
  ;; Формируем CSV
  userstory-id)


