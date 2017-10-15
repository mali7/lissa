(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  ;; See how-is-weather-input for weather categories
  ))
  
;;	What is your favorite weather ?
;;	(0 my favorite weather is 0)
;;	favorite-weather
;;		gist-question: (1 what 2 favorite weather 3)
  
	

(READRULES '*specific-answer-from-favorite-weather-input*
  '(
  1 (0 ? 0)
     2 ((Gist \.)  (favorite-weather)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (favorite-weather)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (favorite-weather)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (favorite-weather)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-favorite-weather-input*
   '(

   ))
  
 (READRULES '*unbidden-answer-from-favorite-weather-input*
   '(

   ))
		
 (READRULES '*question-from-favorite-weather-input*
    '(
    1 (0 what 2 you 0)
       2 (What is your favorite weather ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What is your favorite weather ?) (0 :gist)
	  1 (0 ? 0)
       2 (What is your favorite weather ?) (0 :gist)
    ))

(READRULES '*reaction-to-favorite-weather-input*
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
