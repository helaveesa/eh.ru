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
   (list :navmain (tpl:navmain (menu))
         :content (tpl:contentblock
                   (list :content (alexandria:read-file-into-string filename))))))

;; main

(restas:define-route main ("/")
  (tpl:root
   (list :navmain (tpl:navmain (menu))
         :content (concatenate 'string
                                (tpl:platform)
                                (tpl:ecosystem)
                                (tpl:amc)
                                (tpl:solutions)
                                (tpl:thrive)
                                (tpl:app)))))


;; plan file pages

(defmacro def/route (name param &body body)
  `(progn
     (restas:define-route ,name ,param
       ,@body)
     (restas:define-route
         ,(intern (concatenate 'string (symbol-name name) "/"))
         ,(cons (concatenate 'string (car param) "/") (cdr param))
       ,@body)))


(def/route about ("about")
  (old-page "content/about.htm"))

(def/route about2 ("about_company")
  (old-page "content/about_company.htm"))

(def/route about3 ("about_clients")
  (old-page "content/about_clients.htm"))

(def/route about4 ("work")
  (old-page "content/work.htm"))

(def/route about5 ("greenpage")
  (old-page "content/greenpage.htm"))

(def/route galery ("galery")
  (old-page "content/galery.htm"))

(def/route galery2 ("city")
  (old-page "content/city.htm"))

(def/route galery4 ("inter")
  (old-page "content/inter.htm"))

(def/route galery6 ("landshaf")
  (old-page "content/landshaf.htm"))

(def/route catalog ("catal")
  (old-page "catalog/catal.htm"))

(def/route catalog2 ("catr")
  (old-page "catalog/catr.htm"))

(def/route catalog21 ("dekor")
  (old-page "catalog/catalog-flower/dekor.htm"))

(def/route catalog22 ("visokie")
  (old-page "catalog/catalog-flower/visokie.htm"))

(def/route catalog3 ("catk")
  (old-page "catalog/catk.htm"))

(def/route catalog31 ("plastic")
  (old-page "catalog/catalog-kashpo/plastic.htm"))

(def/route catalog32 ("metall")
  (old-page "catalog/catalog-kashpo/metall.htm"))

(def/route catalog33 ("keramika")
  (old-page "catalog/catalog-kashpo/keramika.htm"))

(def/route catalog4 ("iskuss")
  (old-page "catalog/iskuss.htm"))

(def/route catalog5 ("prices_flower")
  (old-page "catalog/catalog-flower/prices_flower.htm"))

(def/route catalog51 ("prices_kashpo")
  (old-page "catalog/catalog-kashpo/prices_kashpo.htm"))

(def/route catalog52 ("prices_iskusstv_r")
  (old-page "catalog/iskusstv-r/prices_iskusstv_r.htm"))

(def/route serv-price ("ozelen_fitodiz")
  (old-page "content/ozelen_fitodiz.htm"))

(def/route serv-price2 ("prof_uhod")
  (old-page "content/prof_uhod.htm"))

(def/route service ("service")
  (old-page "content/service.htm"))

(def/route service2 ("ozelenenie")
  (old-page "content/ozelenenie.htm"))

(def/route service21 ("ozelenenie_offic")
  (old-page "content/ozelenenie_offic.htm"))

(def/route service22 ("city_ozelenenie")
  (old-page "content/city_ozelenenie.htm"))

(def/route service3 ("fitodiz")
  (old-page "content/fitodiz.htm"))

(def/route service31 ("fitodiz_int")
  (old-page "content/fitodiz_int.htm"))

(def/route service32 ("flower_offic")
  (old-page "content/flower_offic.htm"))

(def/route service33 ("rastenie_offic")
  (old-page "content/rastenie_offic.htm"))

(def/route service4 ("oforml_int")
  (old-page "content/oforml_int.htm"))

(def/route service41 ("oforml_offic")
  (old-page "content/oforml_offic.htm"))

(def/route service42 ("oforml_cafe")
  (old-page "content/oforml_cafe.htm"))

(def/route service43 ("oforml_hotel")
  (old-page "content/oforml_hotel.htm"))

(def/route service44 ("oforml_spa")
  (old-page "content/oforml_spa.htm"))

(def/route service45 ("oforml_shop")
  (old-page "content/oforml_shop.htm"))

(def/route service46 ("oforml_car")
  (old-page "content/oforml_car.htm"))

(def/route service5 ("zimsad")
  (old-page "content/zimsad.htm"))

(def/route service51 ("zimsad_cottadge")
  (old-page "content/zimsad_cottadge.htm"))

(def/route service52 ("dizint_zimsad")
  (old-page "content/dizint_zimsad.htm"))

(def/route service53 ("rastenie_zimsad")
  (old-page "content/rastenie_zimsad.htm"))

(def/route service6 ("kompoz_flower")
  (old-page "content/kompoz_flower.htm"))

(def/route service7 ("NY")
  (old-page "content/NY.htm"))

(def/route service8 ("landshafdiz")
  (old-page "content/landshafdiz.htm"))

(def/route service81 ("landshaf_city")
  (old-page "content/landshaf_city.htm"))

(def/route service82 ("landshaf_village")
  (old-page "content/landshaf_village.htm"))

(def/route service9 ("uhod_room_flower")
  (old-page "content/uhod_room_flower.htm"))

(def/route service10 ("fitoenergy")
  (old-page "content/fitoenergy.htm"))

(def/route contacts ("contacts")
  (old-page "content/contacts.htm"))

(def/route contacts2 ("telephon")
  (old-page "content/telephon.htm"))

(def/route contacts3 ("zakaz")
  (old-page "content/zakaz.htm"))

(def/route akcii ("akcii")
  (old-page "content/akcii.htm"))

(def/route mapsite ("mapsite")
  (old-page "content/mapsite.htm"))

(def/route news ("news")
  (old-page "content/news.htm"))

(def/route news2 ("intel")
  (old-page "content/intel.htm"))

(def/route news3 ("raduga")
  (old-page "content/raduga.htm"))

(def/route news4 ("umo_konsalt")
  (old-page "content/umo_konsalt.htm"))

(def/route news5 ("optek")
  (old-page "content/optek.htm"))

(def/route articles ("articles")
  (old-page "content/articles.htm"))

(def/route articles2 ("emkosti")
  (old-page "content/emkosti.htm"))

(def/route articles3 ("teory")
  (old-page "content/teory.htm"))

(def/route articles4 ("history_zimsad")
  (old-page "content/history_zimsad.htm"))

(def/route articles5 ("tehnich_har")
  (old-page "content/tehnich_har.htm"))

(def/route articles6 ("spasti_offic")
  (old-page "content/spasti_offic.htm"))

(def/route articles7 ("dom_offic")
  (old-page "content/dom_offic.htm"))

(def/route articles8 ("vibor_offic")
  (old-page "content/vibor_offic.htm"))

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

(restas:mount-submodule -about- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("about"))
  (restas.directory-publisher:*directory* (path "about/")))

(restas:mount-submodule -banner- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("banner"))
  (restas.directory-publisher:*directory* (path "banner/")))

(restas:mount-submodule -catalog- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("catalog"))
  (restas.directory-publisher:*directory* (path "catalog/")))

(restas:mount-submodule -cityozelen- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("cityozelen"))
  (restas.directory-publisher:*directory* (path "cityozelen/")))

(restas:mount-submodule -floweroffic- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("floweroffic"))
  (restas.directory-publisher:*directory* (path "floweroffic/")))

(restas:mount-submodule -gallery- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("gallery"))
  (restas.directory-publisher:*directory* (path "gallery/")))

(restas:mount-submodule -gif- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("gif"))
  (restas.directory-publisher:*directory* (path "gif/")))

(restas:mount-submodule -kashpo- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("kashpo"))
  (restas.directory-publisher:*directory* (path "kashpo/")))

(restas:mount-submodule -kompoziciya- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("kompoziciya"))
  (restas.directory-publisher:*directory* (path "kompoziciya/")))

(restas:mount-submodule -minipick- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("minipick"))
  (restas.directory-publisher:*directory* (path "minipick/")))

(restas:mount-submodule -NY- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("NY"))
  (restas.directory-publisher:*directory* (path "NY/")))

(restas:mount-submodule -oformlenie- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("oformlenie"))
  (restas.directory-publisher:*directory* (path "oformlenie/")))

(restas:mount-submodule -ozelenoffic- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("ozelenoffic"))
  (restas.directory-publisher:*directory* (path "ozelenoffic/")))

(restas:mount-submodule -picindex- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("picindex"))
  (restas.directory-publisher:*directory* (path "picindex/")))

(restas:mount-submodule -rastoffic- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("rastoffic"))
  (restas.directory-publisher:*directory* (path "rastoffic/")))

(restas:mount-submodule -uhodroomfl- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("uhodroomfl"))
  (restas.directory-publisher:*directory* (path "uhodroomfl/")))

(restas:mount-submodule -zimsad- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("zimsad"))
  (restas.directory-publisher:*directory* (path "zimsad/")))

(restas:mount-submodule -resources- (#:restas.directory-publisher)
  (restas.directory-publisher:*baseurl* '("resources"))
  (restas.directory-publisher:*directory* (path "resources/")))
