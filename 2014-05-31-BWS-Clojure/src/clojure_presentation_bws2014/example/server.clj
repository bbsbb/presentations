(ns clojure-presentation-bws2014.example.server
  (:require [clojure-presentation-bws2014.example.checking-account :refer :all]
            [clojure-presentation-bws2014.example.middleware :refer [format-json-params]]
            [org.httpkit.server :refer [run-server]]
            [environ.core :refer [env]]
            [clojure.tools.logging :refer :all]
            [clj-logging-config.log4j :refer :all])
  (:gen-class :main true))

(set-logger! :pattern "[%p] %m (%c)%n")

(def checking-account-app
  ;;-> is a sequential execution macro.
  (-> checking-account-route
      format-json-params))

;;;Entry point for our application
(defn -main []
  (info (str "Starting web server on port: " (env :port)))
  (run-server checking-account-app {:port (env :port)}))
