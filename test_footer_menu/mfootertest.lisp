(in-package #:botanic)

(defun menufootertest ()
  (list :mft
        (mapcar #'(lambda (mft)
                    (list :title (cdr mft) :link (car mft)))))

'("mama" "/mom"))

;;'("12345" "/link"))

                          ;;(list :mitemstest (mapcar #'(lambda (mitemtest)
                                                       ;;(list :title (car mitemtest) :link (car mitemtest))))))

