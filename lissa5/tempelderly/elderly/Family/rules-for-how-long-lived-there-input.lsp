(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((few one two three four five six seven eight nine ten eleven)
    (many twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty)
    (lots thirty forty fifty sixty seventy eighty ninety hundred)))
;; (How long have you lived there ?)
;;	(how-long-lived-there)
;;		from-how-long-lived-there-input
;;			(0 I lived there for 0)
;;			gist-question:(3 how long 1 you lived 0)

 (READRULES '*specific-answer-from-how-long-lived-there-input*
   '(1 (0 1 years 0)
        2 (0 lots 1 years)
          3 ((I lived there for more than 2 years \.)  (how-long-lived-there)) (0 :gist) 
        2 (0 many years)
          3 ((I lived there for 2 years \.)  (how-long-lived-there)) (0 :gist) 				  
        2 (0 few years)
          3 ((I lived there for 2 years \.)  (how-long-lived-there)) (0 :gist) 				   
     1 (0 whole life 0)
        2 ((I lived there my whole life \.) (how-long-lived-there)) (0 :gist)
     ))
       
       
 (READRULES '*thematic-answer-from-how-long-lived-there-input*
    '())

 (READRULES '*unbidden-answer-from-how-long-lived-there-input*
    '())
		
 (READRULES '*question-from-how-long-lived-there-input*
    '())

(READRULES '*reaction-to-how-long-lived-there-input*
   '(1 (0 whole life 0)
       2 (Wow\, that\'s amazing! It must really be my home\.) (100 :out)
     1 (0 few 0)
       2 (Oh\, okay\.) (100 :out)
     1 (0 many 0)
       2 (That\'s a long time\. You haven\'t lived anywhere that long\.) (100 :out)
     1 (0 lots 0)
       2 (Wow! I must really feel at home there\, having lived there for so long\.) (100 :out)
	))
); end of eval-when
