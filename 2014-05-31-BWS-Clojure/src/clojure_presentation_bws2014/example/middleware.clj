(ns clojure-presentation-bws2014.example.middleware
  (:require [cheshire.core  :refer [parse-stream]]
            [clojure.java.io :refer [reader]]))

;;;Request middleware - will be attached to all routes.
(defn format-json-params [handler]
  ;;Returns a function that will be executed
  (fn [request]
    (if (= (request :content-type) "application/json")
      (handler (assoc request :json-params (parse-stream (reader (request :body))
                                                         true)))
      (handler request))))
