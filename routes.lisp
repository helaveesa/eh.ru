(in-package #:eh)


;; 404

(defun page-404 (&optional (title "404 Not Found") (content "Страница не найдена"))
  "404:  извините,страница, которую Вы запросили, не находится в нашей базе данных. Скорее всего вы попали на битую ссылку или опечатались при вводе URL")

(restas:define-route not-found-route ("*any")
  (restas:abort-route-handler
   (page-404)
   :return-code hunchentoot:+http-not-found+
   :content-type "text/html"))

(defun old-page (filename)
  (tpl:root
   (list :content (tpl:contentblock
                   (list :content (alexandria:read-file-into-string filename))))))

;; main

(restas:define-route main ("/")
  (tpl:root
   (list :content (concatenate 'string
                               (tpl:platform)
                               (tpl:amc)
                               (tpl:solutions)))))


;; plan file pages

(defmacro def/route (name param &body body)
  `(progn
     (restas:define-route ,name ,param
       ,@body)
     (restas:define-route
         ,(intern (concatenate 'string (symbol-name name) "/"))
         ,(cons (concatenate 'string (car param) "/") (cdr param))
       ,@body)))


(def/route about1 ("about")
  (old-page "content/about.htm"))

(def/route about11 ("biografy")
  (old-page "content/biografy.htm"))

(def/route about2 ("service")
  (old-page "content/service.htm"))

(def/route about3 ("works")
  (old-page "content/works.htm"))

(def/route about4 ("prices")
  (old-page "content/prices.htm"))

(def/route about5 ("customers")
  (old-page "content/customers.htm"))

(def/route about51 ("client_1")
  (old-page "content/client_1.htm"))
(def/route about52 ("client_2")
  (old-page "content/client_2.htm"))
(def/route about53 ("client_3")
  (old-page "content/client_3.htm"))

(def/route about6 ("facts")
  (old-page "content/facts.htm"))

(def/route about61 ("f1")
  (old-page "content/f1.htm"))
(def/route about62 ("f2")
  (old-page "content/f2.htm"))
(def/route about63 ("f3")
  (old-page "content/f3.htm"))
(def/route about64 ("f4")
  (old-page "content/f4.htm"))

(def/route about7 ("faq")
  (old-page "content/faq.htm"))



(def/route specialty1 ("specialty")
  (old-page "content/specialty.htm"))

(def/route specialty2 ("ad_outdoor")
  (old-page "content/ad_outdoor.htm"))

(def/route specialty3 ("exhibition")
  (old-page "content/exhibition.htm"))





(def/route articles1 ("articles")
  (old-page "content/articles.htm"))

(def/route articles2 ("ad")
  (old-page "content/ad.htm"))

(def/route articles3 ("ad_history")
  (old-page "content/ad_history.htm"))

(def/route articles4 ("ad_terminology")
  (old-page "content/ad_terminology.htm"))

(def/route articles5 ("pr")
  (old-page "content/pr.htm"))

(def/route articles6 ("event-marketing")
  (old-page "content/event-marketing.htm"))

(def/route articles7 ("what_pr")
  (old-page "content/what_pr.htm"))

(def/route articles8 ("propaganda_pr")
  (old-page "content/propaganda_pr.htm"))

(def/route articles9 ("pr_terminology")
  (old-page "content/pr_terminology.htm"))




(def/route  lisp1 ("lisp")
  (old-page "content/lisp.htm"))

(def/route  lisp11 ("algoritm")
  (old-page "content/algoritm.htm"))
(def/route  lisp12 ("code")
  (old-page "content/code.htm"))
(def/route  lisp13 ("test")
  (old-page "content/test.htm"))
(def/route  lisp14 ("articles_lisp")
  (old-page "content/articles_lisp.htm"))
(def/route  lisp15 ("lispis")
  (old-page "content/lispis.htm"))

(def/route  news ("news")
  (old-page "content/news.htm"))

(def/route  calendari ("calendari")
  (old-page "content/calendari.htm"))

(def/route  userful-links ("userful_links")
    (old-page "content/userful_links.htm"))

(def/route  contacts ("contacts")
    (old-page "content/contacts.htm"))

(def/route  sitemap ("sitemap")
    (old-page "content/sitemap.htm"))





;; submodules

(restas:mount-submodule -css- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("css"))
  (restas.directory-publisher:*directory* (path "css/")))

(restas:mount-submodule -js- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("js"))
  (restas.directory-publisher:*directory* (path "js/")))

(restas:mount-submodule -img- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("img"))
  (restas.directory-publisher:*directory* (path "img/")))

(restas:mount-submodule -img- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("fon"))
  (restas.directory-publisher:*directory* (path "fon/")))

(restas:mount-submodule -img- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("minipick"))
  (restas.directory-publisher:*directory* (path "minipick/")))

(restas:mount-submodule -img- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("myworks"))
  (restas.directory-publisher:*directory* (path "myworks/")))

(restas:mount-submodule -img- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("reklama"))
  (restas.directory-publisher:*directory* (path "reklama/")))

(restas:mount-submodule -img- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("skrap"))
  (restas.directory-publisher:*directory* (path "skrap/")))

(restas:mount-submodule -resources- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("resources"))
  (restas.directory-publisher:*directory* (path "resources/")))
