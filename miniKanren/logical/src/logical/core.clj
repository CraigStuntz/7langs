(ns logical.core)
(use 'clojure.core.logic)
(use 'clojure.core.logic.pldb)
(use 'clojure.stacktrace)

(defn -main
  "I don't do a whole lot."
  [& args]
  (println (run 5 [q] (membero q [1 2 3]) (membero q [4 5 6])))
  (run 5 [q] (appendo q [2 3] [1 2 3]))
  (db-rel languageo x)
  (db-rel systemo x)
  (db-rel mano x)
  (db-rel womano x)
  (db-rel vitalo p s)
  (db-rel turingo p y)
  (def facts
    (db
      [mano :alan-turig]
      [womano :grace-hopper]
      [mano :leslie-lamport]
      [womano :barbara-liskov]))
  (def facts
    (-> facts
        (db-fact vitalo :alan-turig :dead)
        (db-fact vitalo :grace-hopper :dead)
        (db-fact vitalo :leslie-lamport :alive)
        (db-fact vitalo :barbara-liskov :alive)
        (db-fact turingo :leslie-lamport :2013)
        (db-fact turingo :barbara-liskov :2008)))
  (defn scientisto [p]
    (conde
      [(womano p)]
      [(mano p)]))
  (println (with-db facts
             (run* [q]
                   (scientisto q))))
  (println "Hello, World!"))
