(ns eiga.service
  (:require [io.pedestal.http :as http]
            [io.pedestal.http.route :as route]
            [io.pedestal.http.body-params :as body-params]
            [io.pedestal.http.route.definition.table :refer [table-routes]]
            [ring.util.response :as ring-resp]))

(defn about-page
  [request]
  (ring-resp/response (format "Clojure %s - served from %s"
                              (clojure-version)
                              (route/url-for ::about-page))))

(defn home-page
  [request]
  (ring-resp/response "映画 Home"))

(defn list-movies
  [request]
  (ring-resp/response [{:id 8001 :year 1999 :title "Shiri" :short-title "shiri" :country "South Korea"}]))

(defn get-movie
  [{short-title :short-title}]
  (ring-resp/response {:id 8001 :year 1999 :title "Shiri" :short-title "shiri" :country "South Korea"}))

(defn put-movie
  [request]
  (ring-resp/response "PUT 映画"))

(defn delete-movie
  [request]
  (ring-resp/response "DELETE 映画"))

(defn get-reviews-for-movie
  [request]
  (ring-resp/response "GET 映画 Reviews"))

(defn post-reviews-for-movie
  [request]
  (ring-resp/response "POST 映画 Reviews"))

(defn list-reviews
  [request]
  (ring-resp/response "List 映画 Reviews"))

(defn get-review
  [request]
  (ring-resp/response "GET 映画 Review"))

(defn put-review
  [request]
  (ring-resp/response "PUT 映画 Review"))

(defn delete-review
  [request]
  (ring-resp/response "DELETE 映画 Review"))

;; Defines "/" and "/about" routes with their associated :get handlers.
;; The interceptors defined after the verb map (e.g., {:get home-page}
;; apply to / and its children (/about).
(def common-interceptors [(body-params/body-params) http/html-body])

;; Tabular routes
(def routes #{["/" :get (conj common-interceptors `home-page)]
              ["/about" :get (conj common-interceptors `about-page)]
              ["/movies" :get (conj common-interceptors `list-movies)]
              ["/movies/:short-title" :get (conj common-interceptors `get-movie)]
              ["/movies/:short-title" :put (conj common-interceptors `put-movie)]
              ["/movies/:short-title" :delete (conj common-interceptors `delete-movie)]
              ["/movies/:short-title/reviews" :get (conj common-interceptors `get-reviews-for-movie)]
              ["/movies/:short-title/reviews" :post (conj common-interceptors `post-reviews-for-movie)]
              ["/reviews" :get (conj common-interceptors `list-reviews)]
              ["/reviews/:id" :get (conj common-interceptors `get-review)]
              ["/reviews/:id" :delete (conj common-interceptors `delete-review)]})


;; Consumed by eiga.server/create-server
;; See http/default-interceptors for additional options you can configure
(def service {:env :prod
              ;; You can bring your own non-default interceptors. Make
              ;; sure you include routing and set it up right for
              ;; dev-mode. If you do, many other keys for configuring
              ;; default interceptors will be ignored.
              ;; ::http/interceptors []
              ::http/routes routes

              ;; Uncomment next line to enable CORS support, add
              ;; string(s) specifying scheme, host and port for
              ;; allowed source(s):
              ;;
              ;; "http://localhost:8080"
              ;;
              ;;::http/allowed-origins ["scheme://host:port"]

              ;; Root for resource interceptor that is available by default.
              ::http/resource-path "/public"

              ::http/type :jetty
              ;;::http/host "localhost"
              ::http/port 8080
              ;; Options to pass to the container (Jetty)
              ::http/container-options {:h2c? true
                                        :h2? false
                                        ;:keystore "test/hp/keystore.jks"
                                        ;:key-password "password"
                                        ;:ssl-port 8443
                                        :ssl? false}})
