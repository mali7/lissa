; Is there someone who's bothering you in school?

(eval-when (load eval)
  (mapc 'attachfeat '(
    (yes yeah)
    (someone guy boy girl kid dude friend partner person)
    (tease teased pick picked bully bullied joke jokes laugh laughs laughed ridicule
      ridiculed ridicules hate hates teases picks bullies tickle tickles tickle
      chicken uncle swirlie wedgie)
	(school-subject math science english writing reading history social
	 biology chemistry algebra arithmetic physics recess music orchestra band
	 chorus drama gym PE literature spanish french latin german japanese chinese)
  ))

  (readrules '*specific-answer-from-bullied-input*
    '(1 (0 yes 0)
      2 ((Someone is bullying me in school \.) (bullied)) (0 :gist)
    1 (3 NEG 0)
      2 ((Nobody is bullying me in school \.) (bullied)) (0 :gist)
    1 (0 no 0)
      2 ((Nobody is bullying me in school \.) (bullied)) (0 :gist)
    1 (0 someone 6 school-subject 3 tease 0)
      2 ((Someone is bullying me in 4 \.) (bullied)) (0 :gist)
    1 (0 tease 3 school-subject 0)
      2 ((Someone is bullying me in 4 \.) (bullied)) (0 :gist)
    1 (0 tease 0)
      2 ((Someone is bullying me in school \.) (bullied)) (0 :gist)
    ))

  (readrules '*thematic-answer-from-bullied-input*
    '())

  (readrules '*unbidden-answer-from-bullied-input*
    '())

  (readrules '*question-from-bullied-input*
    '())

  (readrules '*reaction-to-bullied-input*
    '(1 (Someone is bullying me 0)
	    2 (That's not good of them \.) (100 :out)
      1 (Nobody is bullying me 0)
	    2 (I\'m sure I keep my head up in school \.) (100 :out)))
)

