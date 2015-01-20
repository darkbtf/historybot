;;=============================;;
;;                             ;;
;;          deftemplate        ;;
;;                             ;;
;;=============================;;
(deftemplate a..of..b
	(slot sub)
	(slot obj))
(deftemplate syn
	(slot name1)
	(slot name2))

(deftemplate meaning..of..noun
         (slot noun)
	 (slot meaning)
	 (multislot subword))

(deftemplate isIn
        (slot n1)
	(slot n2))
(deftemplate CivilFight
        (slot name)
	(slot time)
	(slot area)
	(slot details)
	(multislot results))

(deftemplate CF_details
        (slot name1)
	(slot name2)
	(slot win))
(deftemplate CF_result
        (slot name)
	(slot des))
(deftemplate religion
        (slot name)
	(slot God))

(deftemplate placeHas (slot n1) (slot resource))
(deftemplate resourceCount (slot n1) (slot count))
(deftemplate placeComment (slot place) (slot comment))


(deftemplate isAncesstorOf (slot parent) (slot child))


(deftemplate historicalSite (slot name) (slot place) (slot builtTime))

(deftemplate CharacterType (slot character) (slot type))
(deftemplate BiGramType (slot c1) (slot c2) (slot type))

(defrule BiGen
(CharacterType (character ?a) (type ?t1))
(CharacterType (character ?b) (type ?t2))
=>
(if (or (= ?t1 Quan) (= ?t2 Quan)) then
     (assert (BiGramType (c1 ?a) (c2 ?b) (type Quan)))
 else
     (assert (BiGramType (c1 ?a) (c2 ?b) (type ?t2)))
   )
)
;;=============================;;
;;                             ;;
;;          defglobal          ;;
;;                             ;;
;;=============================;;
(defglobal
	?*re* = (assert (CF_result (name TonAn) (des bring_God_flee)) )
	?*id* = (assert (CF_details (name1 3man) (name2 TonAn) (win 3man)))
)
;;=============================;;
;;                             ;;
;;          deffacts           ;;
;;                             ;;
;;=============================;;


(deffacts initial-fa 
	(a..of..b (sub 1ten2zu) (obj 2zu))
	(syn (name1 2zu) (name2 owner))
	(syn (name1 2zu) (name2 doer))

	(meaning..of..noun (noun QKF) (meaning QuenNumber) (subword Q K F))
	(meaning..of..noun (noun Q) (meaning gili))
	(meaning..of..noun (noun K) (meaning Katonese))
	(meaning..of..noun (noun F) (meaning Fman))

	(isIn (n1 WanHua) (n2 Taipei))
	(religion (name TonAn) (God ChenHuan))

	(CivilFight (name 3Tfight) (time XienFon3) (area WanHua) (details ?*id*) (results ?*re*))

	(isIn (n1 KeeLon) (n2 Taiwan))
	(isIn (n1 DanSwae) (n2 Taiwan))
	(placeHas (n1 DanSwae) (resource sulfer))
	(placeHas (n1 DanSwae) (resource Shaou))
	(placeHas (n1 KeeLon) (resource sulfer))
	(placeHas (n1 KeeLon) (resource Shaou))

	(isAncesstorOf (parent JinPu) (child AMay))
	(isAncesstorOf (parent BayNan) (child PaiWan))
	(isAncesstorOf (parent YinPu) (child BaBuLa))
	(isAncesstorOf (parent UanSan) (child Kai))

	(historicalSite (name WuFeiTemple) (place Tainan) (builtTime ChenTime))
	(historicalSite (name ConFuTemple) (place Tainan) (builtTime ChenTime))
	(historicalSite (name DaTenHouTemple) (place Tainan) (builtTime ChenTime))
	(historicalSite (name EeZaiGinCity) (place Tainan) (builtTime Qin))

	(CharacterType (character Liou) (type number))
	(CharacterType (character Zan) (type Quan))
	(CharacterType (character Zuan) (type Adj))
	(CharacterType (character Wei) (type verb))
	(CharacterType (character Tu) (type number))
	(CharacterType (character Chen) (type noun))
	(CharacterType (character Xi) (type noun))
	(CharacterType (character Pai) (type noun))
)
;;=============================;;
;;                             ;;
;;    Problem Specific Inf,    ;;
;;                             ;;
;;=============================;;
;problem 27
(defrule getB
(BiGramType {c1 == Liou && c2 == Zan} (type ?t))
=>
(printout t "p27 LiouZan is " ?t crlf))
;problem 22
(defrule p22-query
?p <- (historicalSite {(place == Tainan)&&(builtTime != ChenTime) } )
=>
(printout t "p22 " ?p.name crlf))

;problem 21
(defrule p21-A
?p <- (isAncesstorOf {(parent == JinPu&&child == AMay)})
=>
(printout t "p21, Choice A: "?p.parent "is ancesstor of " ?p.child crlf))
(defrule p21-B
?p <- (isAncesstorOf {(parent == BayNan&&child==BayNan)})
=>
(printout t "p21, Choice B: "?p.parent "is ancesstor of " ?p.child crlf))
(defrule p21-C
?p <- (isAncesstorOf {(parent == YinPu&&child==SiLaYa)})
=>
(printout t "p21, Choice C: "?p.parent "is ancesstor of " ?p.child crlf))
(defrule p21-D
?p <- (isAncesstorOf {(parent == UanSan&&child == Kavalan)})
=>
(printout t "p21, Choice D: "?p.parent "is ancesstor of " ?p.child crlf))

; problem 20
(defrule hasManyResource
?r <- (isIn {n2 == Taiwan} (n1 ?nn))
?cc <- (accumulate (bind ?count 0)
                  (bind ?count (+ ?count 1))
		  ?count
		  (placeHas {(resource == sulfer || resource == Shaou) && n1 == ?nn})
		  )
=>
(assert (resourceCount (n1 ?r) (count ?cc) )) )
(defrule GoodsAreGood
?c <- (accumulate (bind ?count 0)
                  (bind ?count (+ ?count ?r))
		  ?count
		  (resourceCount (n1 ?n) (count ?r)))
=>
(if (> ?c 3) then (printout t "p20, many resources" crlf)
             else (printout t "p20, not many resources" crlf)))


; problem 17
(defrule p17
?p<-(CivilFight (area ?a))
(isIn {n1 == ?a && n2 == Taipei})
=>
(printout t "p17, " ?p.area crlf))

; problem 16
(defrule choiceA
?p <- (meaning..of..noun {noun == QKF})
(meaning..of..noun {(noun == Q) && (meaning == HumanName)})
=>
(printout t "p16, choice A" crlf))

(defrule choiceB
?p <- (meaning..of..noun {noun == QKF})
(meaning..of..noun {(noun == Q) && (meaning == gili)})
(meaning..of..noun {(noun == K) && (meaning == Katonese)})
(meaning..of..noun {(noun == F) && (meaning == Fman)})
=>
(printout t "p16, choice B" crlf))

(defrule choiceC
?p <- (meaning..of..noun {noun == QKF})
(meaning..of..noun {(noun == Q) && (meaning == gili)})
(meaning..of..noun {(noun == K) && (meaning == noWar)})
(meaning..of..noun {(noun == F) && (meaning == noWar)})
=>
(printout t "p16, choice C" crlf))

(defrule choiceD
?p <- (meaning..of..noun {noun == QKF})
(meaning..of..noun {(noun == Q) && (meaning == HumanName)})
(meaning..of..noun {(noun == K) && (meaning == HumanName)})
(meaning..of..noun {(noun == F) && (meaning == HumanName)})
=>
(printout t "p16, choice D" crlf))
; problem 15
(defrule p15
	?a <- (a..of..b {sub == 1ten2zu} (obj ?o))
	(syn {name1 == ?o} (name2 ?ans))
	=>
	(printout t "p15, hello " ?ans crlf))

