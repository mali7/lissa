(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
  
;;	What kinds of dishes do you like to cook?
;;	(0 I like to cook 0)
;;	dishes-like-to-cook
;;		gist-question: (2 what 2 dishes 2 like to cook 3)
 
	

(READRULES '*specific-answer-from-dishes-like-to-cook-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-dishes-like-to-cook-input*
    '())

 (READRULES '*unbidden-answer-from-dishes-like-to-cook-input*
    '())
		
 (READRULES '*question-from-dishes-like-to-cook-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-dishes-like-to-cook-input*
   '( 
	))
); end of eval-when
