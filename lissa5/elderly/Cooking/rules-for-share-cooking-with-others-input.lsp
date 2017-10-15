(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
  
;;	How have you shared cooking with people in your life? 
;;	(0 way 1 cope with giving up driving 0)
;;	share-cooking-with-others
;;		gist-question:	(1 how 2 shared cooking 1 people 3)
	

(READRULES '*specific-answer-from-share-cooking-with-others-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-share-cooking-with-others-input*
    '())

 (READRULES '*unbidden-answer-from-share-cooking-with-others-input*
    '())
		
 (READRULES '*question-from-share-cooking-with-others-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-share-cooking-with-others-input*
   '( 
	))
); end of eval-when
