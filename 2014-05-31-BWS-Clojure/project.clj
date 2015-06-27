(defproject clojure-presentation-bws2014 "0.1.0-SNAPSHOT"
  :description "Code samples for the Bulgarian Web Summit 2014 Clojure Presentation"
  :url "https://github.com/bbsbb/clojure-presentaion-bws2014.git"
  :dependencies [[org.clojure/clojure "1.6.0"]
                 ;;HTTP and application layer libraries
                 [http-kit "2.1.18"]
                 [ring/ring-core "1.3.0-RC1"]
                 [compojure "1.1.8"]
                 [liberator "0.11.0"]

                 ;;This dependency is required since ring 1.2
                 ;;It is supposed to be removed with the official
                 ;;release of ring-core 1.3
                 ;;@TODO Update as soon as the dependency is not required.
                 [javax.servlet/servlet-api "2.5"]

                 ;;Utilities libraries
                 [cheshire "5.3.1"]
                 [environ "0.5.0"]
                 [org.clojure/tools.logging "0.2.6"]
                 [clj-logging-config "1.9.10"]]

  ;;Required plugin for correct merging of the :env
  ;;key into the settings map.
  :plugins [[lein-environ "0.5.0"]]

  ;;Application profiles. Those are merged in the env
  ;;map by the environ library.
  :profiles  {:production {:env {:production true
                                 :port 9999}}
              ;;Development profile
              :dev {:dependencies [[ring-mock "0.1.5"]]
                    :env {:dev true
                          :port 3333}}}

  ;;Application entry point
  :main clojure-presentation-bws2014.example.server)
