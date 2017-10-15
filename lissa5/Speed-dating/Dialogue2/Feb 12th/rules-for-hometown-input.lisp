(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((Cities Northern-Cities North-Western-Cities Southern-Cities South-Western-Cities Eastern-Cities South-to-Rochester Central-Cities)
	(Northern-Cities Chicago Indianapolis Columbus Detroit Cleveland)
	(North-Western-Cities Seattle)
	(South-Western-Cities Phoenix)
	(Southern-Cities Houston Dallas Austin Miami)
	(South-to-Rochester Atlanta Charlotte)
	(Western-Cities LA Francisco)
	(Eastern-Cities Boston NYC Philadelphia Washington Baltimore Manhathan Brooklyn)
    (Central-Cities Memphis Denver Kansas)
	(states Southern-States Eastern-States Western-States Central-States Northern-States)
    (Southern-States Florida Texas Arizona Georgia)
    (Eastern-States Pennsylvania)
	(Western-States California)
	(Central-States Virginia Carolina Maryland)
	(Northern-States Ohio Michigan Vermont Massachusetts Minessota)
	))
	
;; (where did you grow up ?)
;;	(hometown)
;;		from-hometown-input
;;			(I grew up in 1 0)
;;			gist-question: (where 2 grow up 0)

 
 (READRULES '*specific-answer-from-hometown-input*
 '(1 (0 New York City 0) 
        2 ((I grew up in 2 3 4 \.)  (hometown)) (0 :gist)
   1 (0 Los Angeles 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Antonio 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Jose 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Diego 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 Cities 0) 
        2 ((I grew up in 2 \.)  (hometown)) (0 :gist) 
   1 (0 States 0) 
        2 ((I grew up in 2 \.)  (hometown)) (0 :gist) 		
   ))
 
 (READRULES '*thematic-answer-from-hometown-input*
    '())

 (READRULES '*unbidden-answer-from-hometown-input*
	())

 (READRULES '*question-from-hometown-input* 
    '(1 (0 what 0 you 0)
        2 (where did you grow up ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (where did you grow up ?) (0 :gist)
	  1 (0 where 0 you from 0)
        2 (where did you grow up ?) (0 :gist)
      1 (0 where 0 you grow 0)
        2 (where did you grow up ?) (0 :gist)		
     ))
 
 (READRULES '*reaction-to-hometown-input*  
 '(1 (0 1 0)
   2 (Cool! You were born in Maida Vale\, however\, since you always were on the move\, you could not think of any hometown\.) (100 :out)
   )); end of *reaction-to-hometown-input*
 
); end of eval-when

