(in-package #:eh)

(defun menu ()
  '((:link "/" :title "Главная")
    (:link "/about" :title "Обо-мне")
    (:link "/biografy" :title "Моя-биография")
    (:link "/service" :title "Предоставляемые-услуги")
    (:link "/works" :title "Портфолио")
    (:link "/prices" :title "Цены-на-услуги")
    (:link "/customers" :title "Наши-клиенты")
    (:link "/clt1" :title "Клиент-1")
    (:link "/clt2" :title "Клиент-2")
    (:link "/clt3" :title "Клиент-3")
    (:link "/facts" :title "Факты-о-рекламе")
    (:link "/f1" :title "Факт-№-1")
    (:link "/f2" :title "Факт-№-2")
    (:link "/f3" :title "Факт-№-3")
    (:link "/f4" :title "Факт-№-4")
    (:link "/faq" :title "FAQ")
    (:link "/specialty" :title "Специализация")
    (:link "/ad_outdoor" :title "Наружная реклама")
    (:link "/exhibition" :title "Выставочная-деятельность")
    (:link "/articles" :title "Статьи")
    (:link "/ad" :title "РЕКЛАМА")
    (:link "/ad_campany" :title "Рекламная-кампания")
    (:link "/ad_history" :title "История-рекламы")
    (:link "/ad_terminology" :title "Терминология-рекламы")
    (:link "/pr" :title "PR")
    (:link "/event_marketing" :title "Event-marketing")
    (:link "/what_pr" :title "Что-такое-PR?")
    (:link "/propaganda_pr" :title "Пропаганда-и-PR")
    (:link "/pr_terminology" :title "Терминология-PR")
    (:link "/lisp" :title "Сайты-на-Lisp")
    (:link "/algoritm" :title "Написание-алгоритма")
    (:link "/code" :title "Написание-кода")
    (:link "/test" :title "Тестирование-кода")
    (:link "/articles_lisp" :title "Статьи-о-PR")
    (:link "/lispis" :title "Lisp")
    (:link "/news" :title "Новости")
    (:link "/userful_links" :title "Полезные-ссылки")
    (:link "/contacts" :title "Контакты")
    (:link "/sitemap" :title "Карта-сайта")))

;; start
(restas:start '#:eh :port 2002)
(restas:debug-mode-on)
;; (restas:debug-mode-off)
(setf hunchentoot:*catch-errors-p* t)
