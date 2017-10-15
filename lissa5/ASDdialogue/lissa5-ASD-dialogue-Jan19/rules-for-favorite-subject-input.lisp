; favorite-subject


(eval-when (load eval)
  (mapc 'attachfeat '(
	(school-subject math science english writing reading history social
	 biology chemistry algebra arithmetic physics recess music orchestra band
	 chorus drama gym PE literature spanish french latin german japanese chinese)
  ))


  (readrules '*specific-answer-from-favorite-subject-input*
    '(1 (0 like school-subject 0)
      2 ((My favorite subject is 3 \.) (favorite-subject)) (0 :gist)
    1 (0 favorite 3 school-subject 0)
      2 ((My favorite subject is 4 \.) (favorite-subject)) (0 :gist)
    1 (school-subject)
      2 ((My favorite subject is 1 \.) (favorite-subject)) (0 :gist)
    ))


  (readrules '*thematic-answer-from-favorite-subject-input*
    '())


  (readrules '*unbidden-answer-from-favorite-subject-input*
    '())


  (readrules '*question-from-favorite-subject-input*
    '())


  (readrules '*reaction-to-favorite-subject-input*
    '(1 (My favorite subject is 1 \.)
	    2 (I must really enjoy 5 \.) (100 :out)))


)
