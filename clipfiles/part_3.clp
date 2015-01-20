(deftemplate date
    (slot event)
    (multislot people)
    (multislot things)
    (multislot where)
    (slot year (type INTEGER))
    (slot month (type INTEGER))
    (slot day (type INTEGER)))
(deftemplate territory
    "one place becomes territory of a ruler"
    (slot place)
    (slot ruler))
(deftemplate introduce
    "someone introduce a person/thing to another place/person"
    (slot introducer)
    (slot introduced)
    (slot to))
(deftemplate enemy
    (slot first)
    (slot second))
(deftemplate deal_with
    "someone deals with another one with some strategy"
    (slot dealer)
    (slot target)
    (slot strategy))
(deftemplate fight
    (multislot involved)
    (slot place)
    (slot frequency))
(deftemplate development
    (slot place)
    (slot rate (type INTEGER))
    (slot level))
(deftemplate rare
    (slot thing)
    (slot place)
    (slot y_n))
(defrule develop-resource
    "relation with development and resource"
    (development (place ?place) (level high))
    =>
    (bind ?p32-7(assert (rare (thing land) (place ?place) (y_n yes))))
    (bind ?p32-8(assert (rare (thing water) (place ?place) (y_n yes)))))

(defrule develop-resource
    "relation with development and resource"
    (development (place ?place) (level high))
    =>
    (bind ?p32-7(assert (rare (thing land) (place ?place) (y_n yes))))
    (bind ?p32-8(assert (rare (thing water) (place ?place) (y_n yes)))))
(deftemplate need
    (slot subject)
    (slot object))
(defrule need-fight
    (need (subject ?s) (object ?o))
    (rare (thing ?o) (place ?place) (y_n yes))
    =>
    (bind ?p32-11 (assert (fight (involved ?s) (place ?place) (frequency increase)))))
(deftemplate boom
    (slot place)
    (slot year))
(deftemplate amount
    (slot thing)
    (slot amount)
    (slot trend))
(defrule boom_effect
    (boom (place ?place) (year ?y))
    =>
    (assert (amount (thing hobo) (trend decrease))))
(defrule hobo-fight
    (amount (thing hobo) (trend decrease))
    =>
    (bind ?p33-2 (assert (fight (involved human) (frequency decrease)))))
(defglobal
    ?*p28-1* = (assert (territory (place Taiwan) (ruler Qing_dynasty)))
;    ?*date_result* = (run-query* search_date ?p28-1)
;    ?*introduce_fact* = (run-query* introduce-to Dutch Taiwan))
    )
(deffacts myFacts
    (date (event ?*p28-1*) (year 1683))
    (introduce (introducer Dutch) (introduced mango) (to Taiwan))
    (introduce (introducer Dutch) (introduced cattle) (to Taiwan))
    (introduce (introducer Dutch) (introduced tobacco) (to Taiwan))
    (enemy (first Dutch) (second Spanish))
    (enemy (first Dutch) (second Porn_race))
    (enemy (first Dutch) (second Cheng))
    (deal_with (dealer Dutch) (target Spanish) (strategy expel))
    (deal_with (dealer Dutch) (target Cheng) (strategy attack))
    (development (place west_plain) (level high))
    (need (subject human) (object land))
    (need (subject human) (object water)
    ))
