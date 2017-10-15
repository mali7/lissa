(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
  
;;	What do you remember about your first car ?
;;	(0 my first car 0)
;;	first-car
;;		gist-question: (2 what 1 you remember 2 first car 3)  
	

(READRULES '*specific-answer-from-first-car-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-first-car-input*
    '())

 (READRULES '*unbidden-answer-from-first-car-input*
    '())
		
 (READRULES '*question-from-first-car-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-first-car-input*
   '( 
	))
); end of eval-when
