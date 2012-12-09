(in-package #:eh)

(defun menu ()
  '((:link "/" :title "Главная")
    (:link "/about" :title "Обо -мне")
    (:link "/service" :title "")
    (:link "/works" :title "")
    (:link "/prices" :title "")
    (:link "/customers" :title "")
    (:link "/facts" :title "")
    (:link "/faq" :title "")
    (:link "/specialty" :title "")
    (:link "/ad_outdoor" :title "")
    (:link "/exhibition" :title "")
    (:link "/articles" :title "")
    (:link "/ad" :title "")
    (:link "/ad_history" :title "")
    (:link "/ad_terminology" :title "")
    (:link "/pr" :title "")
    (:link "/event_marketing" :title "")
    (:link "/what_pr" :title "")
    (:link "/propaganda_pr" :title "")
    (:link "/lisp" :title "")
    (:link "/news" :title "")
    (:link "/userful_links" :title "")
    (:link "/contacts" :title "")
    (:link "/sitemap" :title "")))

;; start
(restas:start '#:eh :port 2002)
(restas:debug-mode-on)
;; (restas:debug-mode-off)
(setf hunchentoot:*catch-errors-p* t)
