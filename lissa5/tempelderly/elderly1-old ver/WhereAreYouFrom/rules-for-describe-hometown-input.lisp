;; It looks like there are no gist clause trees here, which might be appropriate because this question is so open-ended
;; That said, it might be a good idea to get a sense of whether the user's hometown was a city, rural, suburban...

(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '())
    
;; (tell me more about your hometown ?)
;;	(describe-hometown)
;;		from-describe-hometown-input
;;			(0 where I grew up is 0)
;;			gist-question:(3 tell me more 4 hometown 0)

 (READRULES '*specific-answer-from-describe-hometown-input*
   '(1 (0)
       2 ((Nothing found for how where I grew up is \.) (describe-hometown)) (0 :gist)))
       
 (READRULES '*thematic-answer-from-describe-hometown-input*
    '())

 (READRULES '*unbidden-answer-from-describe-hometown-input*
    '())
		
 (READRULES '*question-from-describe-hometown-input*
    '())

(READRULES '*reaction-to-describe-hometown-input*
   '(1 (Cool\, Where I grew up is important in shaping who I am \.) (100 :out)
	))
); end of eval-when
