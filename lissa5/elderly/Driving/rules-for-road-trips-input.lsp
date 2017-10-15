(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
  
;;	Have you ever taken a fun road trip ?
;;	(0 I 1 never taken 2 road trip 0)  (0 I took 2 road trip 0) 
;;	road-trips
;;	gist-question: (1 have you 4 road trip 4)

(READRULES '*specific-answer-from-road-trips-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-road-trips-input*
    '())

 (READRULES '*unbidden-answer-from-road-trips-input*
    '())
		
 (READRULES '*question-from-road-trips-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-road-trips-input*
   '( 
	))
); end of eval-when
