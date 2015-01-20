(deftemplate event
  (slot id)
  (slot subject)
  (slot object)
  (slot action)
  (slot time)
  (slot location)
)

(deftemplate entity
    (slot id)
    (slot type)
  (slot name)
  (slot born)
  (slot dead)
  (slot race)
)

(deftemplate book
  (slot id)
  (slot title)
  (slot author)
  (slot event)
)

(deffacts init
  (entity (id 1001) (name chendi) (type human) (born 1571) (race han))
  (event (id 2001) (subject 1001) (action arrive) (location taiwan))
  (book (id 3001) (title dongfanji) (author 1001) (event 2001))
  (event (id 2002) (subject 1001) (object 3001) (action write) (time 1601) )

  (entity (id 1002) (name yuyonghe) (type human) (race han))
  (event (id 2003) (subject 1002) (action arrive) (location west-taiwan))
  (book (id 3002) (title bihaijiyou) (author 1002) (event 2003))
  (event (id 2004) (subject 1002) (object 3002) (action write) (time 1696))

  (entity (id 1003) (name qing) (type government))
  (event (id 2005) (subject 1003) (action rule) (location taiwan))
  (book (id 3003) (title fanshecaifengtu) (event 2005))
)

(defrule earlier
  (event (id ?id1) (time ?tm1))
  (event (id ?id2) (time ?tm2))
  (< ?tm1 ?tm2)
  =>
  (assert (earlier ?id1 ?id2))
)

; description

(defrule answer1
  (event (id ?eid1) (location taiwan))
  (book (id ?bid) (title ?bookname) (event ?eid1))
  (event (id ?eid2) (action write) (subject ?aid) (object ?bid))
  (entity (id ?aid) (race han))
  =>
  (assert (prob1-1 ?bookname))
)

(defrule answer2
  (event (id ?eid1) (location west-taiwan))
  (book (id ?bid) (title ?bookname) (event ?eid1))
  =>
  (assert (prob1-2 ?bookname))
)

(defrule answer3
  (event (id ?eid1) (subject ?uid) (action rule) (location taiwan))
  (book (id ?bid) (title ?bookname) (event ?eid1))
  =>
  (assert (prob1-3 ?bookname))
)

(defrule prob1-A
  (prob1-1 dongfanji)
  (prob1-2 bihaijiyou)
  (prob1-3 fanshecaifengtu)
  =>
  (assert (prob1 A))
)

(defrule prob1-B
  (prob1-1 dongfanji)
  (prob1-2 taihaishichalu)
  (prob1-3 fanshecaifengtu)
  =>
  (assert (prob1 B))
)

(defrule prob1-C
  (prob1-1 bihaijiyou)
  (prob1-2 fanshecaifengtu)
  (prob1-3 dongfanji)
  =>
  (assert (prob1 C))
)

(defrule prob1-D
  (prob1-1 taihaishichalu)
  (prob1-2 bihaijiyou)
  (prob1-3 fanshecaifengtu)
  =>
  (assert (prob1 D))
)
