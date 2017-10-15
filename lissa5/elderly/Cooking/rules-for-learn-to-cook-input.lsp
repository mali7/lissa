(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
  
;;	How did you learn to cook?
;;	(0 I learned cooking 0)  (0 I do not know 2 cook 0) 
;;	learn-to-cook
;;		gist-question:(1 how 2 learn to cook 4) 


 
	

(READRULES '*specific-answer-from-learn-to-cook-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-learn-to-cook-input*
    '())

 (READRULES '*unbidden-answer-from-learn-to-cook-input*
    '())
		
 (READRULES '*question-from-learn-to-cook-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-learn-to-cook-input*
   '( 
	))
); end of eval-when
