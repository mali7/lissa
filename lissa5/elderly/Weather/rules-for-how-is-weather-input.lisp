(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (weather-rain rain rainey raining drizzling sprinkling pouring wet)
  (weather-snow snow snowy snowing cold freezing blizzard hail hailing ice icy)
  (weather-sun sun sunny warm hot pleasant sunshine clear)
  (weather-other wind windy breeze breezy gusty fog foggy humid cloudy)
  ))

;;	How is the weather outside ?
;;	how-is-weather
;; (0 the weather outside is 0)
;;	gist question: (2 how 2 weather 3)

	
(READRULES '*specific-answer-from-how-is-weather-input*
  '(
  ; "If subject gives a descriptive answer" "If subject says only a few words" ?
  ; should I try to detect specific words, i.e. if it's raining out LISSA responds
  ; "good thing I brought an umbrella" ?

  1 (0 ? 0)
     2 ((Gist \.)  (how-is-weather)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (how-is-weather)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (how-is-weather)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (how-is-weather)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-how-is-weather-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-how-is-weather-input*
  '(
  ;1 (0 weather-rain 2 favorite 0)
  ;   2 ((My favorite weather is rain \.)  (how-is-weather)) (0 :gist)
  ; "It's raining. That's my favorite type of weather" <-- favorite-weather

  ; "It's raining now, but it's supposed to be sunny later" <-- weather-forecast
  ))
		
 (READRULES '*question-from-family-neighbor-pet-input*
    '(
    1 (0 what 2 you 0)
       2 (How is the weather outside ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (How is the weather outside ?) (0 :gist)
	  1 (0 ? 0)
       2 (How is the weather outside ?) (0 :gist)
    ))

(READRULES '*reaction-to-how-is-weather-input*
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
