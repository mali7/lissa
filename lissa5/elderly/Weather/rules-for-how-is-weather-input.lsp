(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))

;;	How is the weather outside ?
;;	how-is-weather
;; (0 the weather outside is 0)
;;	gist question: (2 how 2 weather 3)

	
(READRULES '*specific-answer-from-how-is-weather-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-how-is-weather-input*
    '())

 (READRULES '*unbidden-answer-from-how-is-weather-input*
    '())
		
 (READRULES '*question-from-family-neighbor-pet-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-how-is-weather-input*
   '( 
	))
); end of eval-when
