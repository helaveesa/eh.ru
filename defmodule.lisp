(require 'closer-mop)
(require 'postmodern)
(require 'restas)
(require 'closure-template)
(require 'restas-directory-publisher)
(require 'anaphora)
(require 'cl-base64)


(restas:define-module #:eh
    (:use #:closer-mop #:cl #:iter #:alexandria #:anaphora #:postmodern)
  (:shadowing-import-from :closer-mop
                          :defclass
                          :defmethod
                          :standard-class
                          :ensure-generic-function
                          :defgeneric
                          :standard-generic-function
                          :class-name))


(in-package #:eh)

(let ((path '(:RELATIVE "eh")))
  (setf asdf:*central-registry*
        (remove-duplicates (append asdf:*central-registry*
                                   (list (merge-pathnames
                                          (make-pathname :directory path)
                                          (user-homedir-pathname))))
                           :test #'equal)))



(defparameter *basedir*
  (asdf:component-pathname (asdf:find-system '#:eh)))

(defun path (relative)
  (merge-pathnames relative *basedir*))

(closure-template:compile-template :common-lisp-backend (path "navmain.htm"))
(closure-template:compile-template :common-lisp-backend (path "footer.htm"))
(closure-template:compile-template :common-lisp-backend (path "sections.htm"))
(closure-template:compile-template :common-lisp-backend (path "templates.htm"))
