; This is a small trial pattern base for reacting to the user's
; answer concerning what s/he likes about Rochester.

; We also provide features, supplementing the generic ones in
; "general-word-data.lisp", relevant to the topic here.

(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '(; 10/2/15 ZR
	(social-environment people community university)
	(weather cold snow snows snowy winter)
	(urban-life streets)
	(much many)
	(culture art museum music)
	(nice good)
	(cuisine food restaurant eating)
	(restaurant restaurants diner diners)
	(food foods garbage)
    ))

;; N.B.: FOR THE DECLARATIVE GIST CLAUSES OBTAINED FROM THE USER'S 
;;       RESPONSE TO A LISSA QUESTION, EACH OUTPUT FROM THE CORRESPONDING 
;;       CHOICE PACKETS (DIRECTLY BELOW) MUST BE OF FORM 
;;          (WORD-DIGIT-LIST KEY-LIST), E.G.,
;;          ((My favorite class was 2 3 \.) (favorite-class))
;;       BY CONTRAST, QUESTIONS OBTAINED FROM THE USER RESPONSES,
;;       AND LISSA REACTIONS TO USER RESPONSES, CURRENTLY CONSIST
;;       JUST OF A WORD-DIGIT LIST, WITHOUT A KEY LIST.

; phrases for gist extraction:

 
 (READRULES '*specific-answer-from-like-about-rochester-input*
 '(1 (0 like 3 weather 0)
    2 ((I like the weather in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 weather 2 nice 0)
    2 ((I like the weather in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 weather 0)
    2 ((I like the weather in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 not 5 much 0)
	2 ((no opinion about what I like in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 much 3 city 0)
	2 ((no opinion about what I like in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 not 1 around 0)
	2 ((no opinion about what I like in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 like 3 cuisine 0) ;;;;;;;;;;;;;;;
	2 ((I like eating in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 cuisine 2 nice 0) 
	2 (0 restaurant 0)
	 3 ((I like some restaurants in Rochester \.) (like-rochester)) (0 :gist)
    2 (0 food 0)
	 3 ((I like some foods in Rochester \.) (like-rochester)) (0 :gist)   
   1 (0 social-environment 0)
	2 ((I like 2 in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 culture 0) 
	2 ((I like 2 in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 urban-life 0) 
	2 ((I like 2 in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 festivals 0) 
	2 ((I like festivals in Rochester \.) (like-rochester)) (0 :gist)
   1 (0 3 0) 
	2 ((Nothing found for what I like in Rochester  \.) (like-rochester)) (0 :gist)
	
 ))
 
 (READRULES '*thematic-answer-from-like-about-rochester-input*
    '())

 (READRULES '*unbidden-answer-from-like-about-rochester-input*
 ; I believe we could add some thing about restaurants specially those we are gonna ask later about. like dinaseur bbq
 ; or garbage plate
    '(1 (0 not like 3 weather)
		2 ((I do not like the weather in Rochester \.) (not-like-rochester)) (0 :gist)
	  1 (0 weather 2 not nice 0)
		2 ((I do not like the weather in Rochester \.) (not-like-rochester)) (0 :gist)
	))

 (READRULES '*question-from-like-about-rochester-input* 
    '(1 (0 what 0 you 0)
		2 (what do you like about Rochester ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what do you like about Rochester ?) (0 :gist)
	  1 (0 what 0 you like 0)
        2 (what do you like about Rochester ?) (0 :gist)
     ))
 
 (READRULES '*reaction-to-like-about-rochester-input*  
 '(1 (0 I like 0 \.)
      2 (0 weather 0)
		3 (Really? you wish it would be warmer in the winter \.) 
        (100 :out)
	  2 (0 cuisine 0)
		3 (So I should be a fan of eating \.) ; Aren't we all!
		(100 :out)
	  2 (0 culture 0)
	    3 (so I care about culture\, Rochester is good for that \.)
        (100 :out)
	  2 (0 social-environment 0)	
		3 (You also like the social environment \.)
		(100 :out)
	  2 (0 urban-life 0)
        3 (You also like the city and streets \.)	
		(100 :out)
     2 (0 festivals 0)
        3 (You love festivals too \. They are so fun \.)	
		(100 :out)
   1 (0 no opinion 0 )
	  2 (You are sure I would find many interesting things here if I go around \.)
	    (100 :out)
   
   ;1 (0 what 3 you like 0)
   ;   2 (Your favorite thing about Rochester so far is the schools here\.)
	;	(100 :out)
	1 (0 Nothing found 0)
      2 (That\'s right\.)
		(100 :out)	
 )); end of *reaction-to-like-about-rochester-input*

); end of eval-when