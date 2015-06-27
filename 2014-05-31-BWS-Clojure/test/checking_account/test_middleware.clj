(ns checking-account.test-middleware
  (:require [clojure.test :refer :all]
            [clojure-presentation-bws2014.example.middleware :refer [format-json-params]]
            [ring.mock.request :refer :all]
            [cheshire.core :refer :all]))

;;;; This is an example of unit testing via clojure.test
(deftest test-json-middleware
  ;;What is wrong with this test?
  (let [post-request (request :post
                              "checking-account"
                              (generate-string {:test "me"}))
        json-wrapper (format-json-params (fn [request & _] request))] ;We cheat a bit, define an anonymous function as handler.
    ;;Json type requests get parsed.
    (is (get-in (json-wrapper (content-type post-request "application/json")) [:json-params :test]))
    ;;Same request with an urlencoded content type does not get parsed.
    (is (not (contains? (json-wrapper post-request) :json-params)))))
