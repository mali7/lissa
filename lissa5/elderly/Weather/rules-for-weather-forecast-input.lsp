(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
   
;;	How is the weather forecast for this evening ?
;;	(0 the weather forecast for this evening is 0)
;;	weather-forecast
;;		gist question: (1 how 3 weather forecast 4)   
		
	

(READRULES '*specific-answer-from-weather-forecast-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-weather-forecast-input*
    '())

 (READRULES '*unbidden-answer-from-weather-forecast-input*
    '())
		
 (READRULES '*question-from-weather-forecast-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-weather-forecast-input*
   '( 
	))
); end of eval-when
