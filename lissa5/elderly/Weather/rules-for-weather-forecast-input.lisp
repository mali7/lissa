(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  ;; See how-is-weather-input for weather categories
  ))
   
;;	How is the weather forecast for this evening ?
;;	(0 the weather forecast for this evening is 0)
;;	weather-forecast
;;		gist question: (1 how 3 weather forecast 4)   
		
	

(READRULES '*specific-answer-from-weather-forecast-input*
  '(
  1 (0 ? 0)
     2 ((Gist \.)  (weather-forecast)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (weather-forecast)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (weather-forecast)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (weather-forecast)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-weather-forecast-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-weather-forecast-input*
  '(

  ))
		
 (READRULES '*question-from-weather-forecast-input*
    '(
    1 (0 what 2 you 0)
       2 (How is the weather forecast for this evening ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (How is the weather forecast for this evening ?) (0 :gist)
	  1 (0 ? 0)
       2 (How is the weather forecast for this evening ?) (0 :gist)
    ))

(READRULES '*reaction-to-weather-forecast-input*
  '( 
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
	))
); end of eval-when
