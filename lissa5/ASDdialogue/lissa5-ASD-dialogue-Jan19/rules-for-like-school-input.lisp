; like-school


(eval-when (load eval)
  (mapc 'attachfeat '(
    (yes yeah)
	(school-subject math science english writing reading history social
	 biology chemistry algebra arithmetic physics recess music orchestra band
	 chorus drama gym PE literature spanish french latin german japanese chinese)
  ))


  (readrules '*specific-answer-from-like-school-input*
    '(1 (0 yes 0)
      2 ((I like school \.) (like-school)) (0 :gist)
    1 (3 NEG 0)
      2 ((I do not like school \.) (like-school)) (0 :gist)
    1 (0 no 0)
      2 ((I do not like school \.) (like-school)) (0 :gist)
    ))


  (readrules '*thematic-answer-from-like-school-input*
    '())


  (readrules '*unbidden-answer-from-like-school-input*
    '(1 (0 like school-subject 0)
	   2 ((My favorite subject is 3 \.) (favorite-subject)) (0 :gist)
	  1 (0 favorite 3 school-subject 0)
	   2 ((My favorite subject is 4 \.) (favorite-subject)) (0 :gist)))


  (readrules '*question-from-like-school-input*
    '())


  (readrules '*reaction-to-like-school-input*
    '(1 (I like school \.)
	    2 (That's very nice \.) (100 :out)
      ;1 (I do not like school \.)
	;    2 (I\'m sorry I don\'t like school \.) (100 :out)))
	)) ; the response to do not like school is handled by a different subschema


)
