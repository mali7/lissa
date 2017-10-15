(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((niece nieces)
    (nephew nephews)
    ))
;; (Have you been to any family gathering recently ?)
;;	(family-gathering)
;;		from-family-gathering-input
;;			 (0 I 2 to 2 wedding 0)
;;			gist-question: (3 have you 2 family gathering 1 recently 0)

 (READRULES '*specific-answer-from-family-gathering-input*
   '(1 (1 NEG 0) 
        2 ((I have been to no wedding recently \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 nephew 0) 
        2 ((I have been to my nephew\'s wedding recently \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 niece 0) 
        2 ((I have been to my niece\'s wedding recently \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 had 2 wedding 0) 
        2 ((I have been to a wedding recently \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 went 2 wedding 0) 
        2 ((I have been to a wedding recently \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 going to 2 wedding 0) 
        2 ((I will go to a wedding soon \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 looking forward 0) 
        2 ((I will go to a wedding soon \.)  (holidays-best-part)) (0 :gist) 		
     ))
       
       
 (READRULES '*thematic-answer-from-family-gathering-input*
    '())

 (READRULES '*unbidden-answer-from-family-gathering-input*
    '())
		
 (READRULES '*question-from-family-gathering-input*
    '(1 (0 what 2 you 0)
        2 (Have you been to any family gathering recently ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (Have you been to any family gathering recently ?) (0 :gist)
	  1 (0 have you 3 wedding 0)
        2 (Have you been to any family gathering recently ?) (0 :gist)
      ))

(READRULES '*reaction-to-family-gathering-input*
   '(1 (0 NEG 0)
       2 (Okay\.) (100 :out)
     1 (0)
       2 (0 have been 0) 
         3 (Oh\, that must\'ve been a great experience\.) (100 :out)
       2 (0 will go 0)
         3 (You wish them the best of luck\. Have fun at the wedding!) (100 :out)
	))
); end of eval-when
