(deffacts jizz-a
  (jizz a)
)

(defrule jizz-a
  (jizz a)
  =>
  (printout t "jizzer" crlf)
)