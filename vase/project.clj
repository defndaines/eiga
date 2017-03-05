(defproject eiga "0.1.0-SNAPSHOT"
  :description "A True and Complete Record of Movies Watched (2000-12-23 - 2007-04-14)"
  :url "https://github.com/defndaines/eiga"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.9.0-alpha14"]
                 [io.pedestal/pedestal.service "0.5.2"]
                 [com.cognitect/pedestal.vase "0.9.0"]
                 [io.pedestal/pedestal.jetty "0.5.2"]
                 [ch.qos.logback/logback-classic "1.2.1" :exclusions [org.slf4j/slf4j-api]]
                 [org.slf4j/jul-to-slf4j "1.7.24"]
                 [org.slf4j/jcl-over-slf4j "1.7.24"]
                 [org.slf4j/log4j-over-slf4j "1.7.24"]]
  :min-lein-version "2.0.0"
  :resource-paths ["config", "resources"]
  :profiles {:dev {:aliases {"run-dev" ["trampoline" "run" "-m" "eiga.server/run-dev"]}
                   :dependencies [[io.pedestal/pedestal.service-tools "0.5.2"]]}
             :uberjar {:aot [eiga.server]}}
  :main ^{:skip-aot true} eiga.server)
