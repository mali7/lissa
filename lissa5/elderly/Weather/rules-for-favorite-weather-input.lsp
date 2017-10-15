(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
  
;;	What is your favorite weather ?
;;	(0 my favorite weather is 0)
;;	favorite-weather
;;		gist-question: (1 what 2 favorite weather 3)
  
	

(READRULES '*specific-answer-from-favorite-weather-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-favorite-weather-input*
    '())

 (READRULES '*unbidden-answer-from-favorite-weather-input*
    '())
		
 (READRULES '*question-from-favorite-weather-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-favorite-weather-input*
   '( 
	))
); end of eval-when
