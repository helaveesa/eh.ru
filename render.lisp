(in-package #:eh)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; default-render
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass eh-render () ())

(defparameter *default-render-method* (make-instance 'eh-render))


;; (defmethod restas:render-object ((designer botanic-render) (data list))
;;   (destructuring-bind (headtitle navpoints content) data
;;     (tpl:root (list :headtitle headtitle
;;                     :content (tpl:base (list :navpoints navpoints
;;                                              :content content
;;                                              :stat (tpl:stat)))))))




