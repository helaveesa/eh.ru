(in-package #:eh)

(defun menu ()
  (list :menugroups
        (mapcar #'(lambda (menugroup)
                    (list :grouptitle (car menugroup) :grouplink (cadr menugroup) :left (caddr menugroup)
                          :menublocks (mapcar #'(lambda (menublock)
                                                  (list :headtitle (car menublock) :headlink (cadr menublock)
                                                        :menuitems (mapcar #'(lambda (menuitem)
                                                                               (list :title (car menuitem) :link (cadr menuitem)))
                                                                           (caddr menublock))))
                                              (cadddr menugroup))))
                '(("Botanical.LAB"
                   "/about"
                   "0"
                   (("О компании"
                     "/about_company"
                     (("Наши клиенты" "/about_clients")
                      ("Этапы работы" "/work")
                      ("Зеленая страничка" "/greenpage")))
                    ("Галерея"
                     "/galery"
                     (("Оформление интерьеров" "/inter")
                      ("Городское озеленение" "/city")
                      ("Ландшафтный дизайн" "/landshaf")
                      ("Услуги по дизайну" "/landshafdiz")
                      ("Услуги по зимнему дизайну" "/dizint_zimsad")
                      ("Выполненные проекты" "/news")))
                    ("Каталог"
                     "/catalog"
                     (("Общие сведения" "/catal")
                      ("Каталог растений" "/catr")
                      ("Каталог кашпо" "/catk")
                      ("Искусственные растения" "/iskuss")))))
                  ("Растения"
                   "/catalog_flower"
                   "83"
                   (("Цветущие растения"
                     "/catr"
                     (("Высокие" "/visokie")
                      ("Декоративные" "/dekor")
                      ("Цены" "/prices_flower")
                      ("Растения для зимнего сада" "/rastenie_zimsad")
                      ("Растения для офиса" "/rastenie_offic")))
                    ("Искусственные растения"
                     "/iskusstv_r"
                     (("Общие сведения" "/iskuss")
                      ("Цены" "/prices_iskusstv_r")))
                    ("Каталог кашпо"
                     "/catalog_kashpo"
                     (("Цены" "/prices_kashpo")
                      ("Пластик" "/plastic")
                      ("Металл" "/metall")
                      ("Керамика" "/keramika")))))
                  ("Услуги"
                   "/service"
                   "175"
                   (("Озеленение"
                     "/ozelenenie"
                     (("Городское озеленение" "/city_ozelenenie")
                      ("Ландшафтные работы в городе" "/landshaf_city")
                      ("Ландшафтные работы за городом" "/landshaf_village")
                      ("Фитодизайн" "/fitodiz")
                      ("Интерьер" "/fitodiz_int")
                      ("Зимний сад" "/zimsad")
                      ("Композиции из цветов" "/kompoz_flower")))
                    ("Оформление интерьеров"
                     "/oforml_int"
                     (("Оформление офиса" "/oforml_offic")
                      ("Оформление кафе" "/oforml_cafe")
                      ("Цветы для офиса" "/flower_offic")
                      ("Растения для офиса" "/rastenie_offic")))
                    ("Новогоднее оформление офиса"
                     "/NY"
                     (("Зимний сад" "/zimsad")
                      ("Оформление spa" "/oforml_spa")
                      ("Оформление Hotel" "/oforml_hotel")
                      ("Оформление коттеджей" "/zimsad_cottadge")))))
                  ("Статьи"
                   "/articles"
                   "258"
                   (("Новости"
                     "/news"
                     (("Емкости для растений" "/emkosti")
                      ("История зимних садов" "/history_zimsad")
                      ("Какие выбрать растения?" "/dom_offic")
                      ("Комнатные растения в офисе" "/spasti_offic")))
                    ("Акции от Botanical.LAB"
                     "/akcii"
                     (("Сад в теории" "/teory")
                      ("Техническое исполнение" "/tehnich_har")))))))))
