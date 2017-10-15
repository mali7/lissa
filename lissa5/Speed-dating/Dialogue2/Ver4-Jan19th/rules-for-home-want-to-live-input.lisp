(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((apartment department complex) ; this seems like a probable speech recognition mistake
    (antique old ancestral)
	(game)
	(luxary mansion villa)
	(country village)
	(water seaside riverside shore lake river)
	(house detached)
	(suburb suburban commuting)
	(think thought)
    ))

;; (What kind of home would you want to live in ?)
;;	(home-want-to-live)
;;		from-home-want-to-live-input
;;			(I like to live in 0)
;;			gist-question:(what kind 2 home 2 want to live 0)     
 
 (READRULES '*specific-answer-from-home-want-to-live-input*
 '(1 (0 apartment 0) 
        2 ((I like to live in an apartment \.)  (home-want-to-live)) (0 :gist) 
   1 (0 antique 0) 
        2 ((I like to live in an antique home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 game 0) 
        2 ((I like to live in a place which has game room \.)  (home-want-to-live)) (0 :gist) 
   1 (0 house 0) 
        2 ((I like to live in a house \.)  (home-want-to-live)) (0 :gist) 
   1 (0 suburb 0) 
        2 ((I like to live in a suburban home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 country 0) 
        2 ((I like to live in a country home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 water 0) 
        2 ((I like to live in a home near water \.)  (home-want-to-live)) (0 :gist) 
   1 (0 luxary 0) 
        2 ((I like to live in a luxary home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 have NEG 0 think 0)
        2 ((I have not thought about home I like to live in \.)  (home-want-to-live)) (0 :gist) 
   1 (0 NEG 0 know 0)
        2 ((I have not thought about home I like to live in \.)  (home-want-to-live)) (0 :gist) 
    ))
 
 (READRULES '*thematic-answer-from-home-want-to-live-input*
    '())

 (READRULES '*unbidden-answer-from-home-want-to-live-input*
	())

 (READRULES '*question-from-home-want-to-live-input* 
    '(1 (0 what 0 you 0)
        2 (what kind of home do you want to live in ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what kind of home do you want to live in ?) (0 :gist)
	  1 (0 what 3 home 5 live 0)
        2 (what kind of home do you want to live in ?) (0 :gist)	
     ))
 
 (READRULES '*reaction-to-home-want-to-live-input*  
 '(1 (0 apartment 0) 
     2 (That is reasonable \. Nice apartments could be found everywhere \.) 
	   (100 :out)
   1 (0 antique 0) 
     2 (Living in an old house would be so cool \.) 
	   (100 :out)
   1 (0 game 0) 
     2 (I should be really into that \.) 
	   (100 :out) 
   1 (0 house 0) 
     2 (That\'s great \.) 
	   (100 :out)
   1 (0 suburban home 0) 
     2 (Living in suburb would be a great idea \.) 
	   (100 :out)
   1 (0 country home 0) 
     2 (You love to live in a peace and quiet country home \.) 
	   (100 :out)
   1 (0 home near water 0) 
     2 (You love living by the water \.) 
	   (100 :out)
   1 (0 luxary 0) 
     2 (Living in a luxary home would cost a lot \.) 
	   (100 :out) 
   1 (0 have not thought 0)
     2 (OK\.) 
	   (100 :out)
   1 (0)
     2 (Cool \!) 
	   (100 :out)   

   )); end of *reaction-to-home-want-to-live-input*

); end of eval-when

