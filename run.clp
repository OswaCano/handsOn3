(deffunction main ()
  (printout t "=== Cargando estructuras de datos (templates) ===" crlf)
  (load "templates.clp")

  (printout t "=== Cargando hechos iniciales (facts) ===" crlf)
  (load "facts.clp")

  (printout t "=== Cargando reglas (rules) ===" crlf)
  (load "rules.clp")

  (printout t "=== Inicializando memoria de trabajo ===" crlf)
  (reset)

  (printout t "=== Ejecutando el sistema de inferencia ===" crlf)
  (run)

  (printout t crlf "=== Ejecución finalizada ===" crlf) 
)

;;CLIPS> (load run.clp)
;;CLIPS> (reset)
;;CLIPS> (run)



