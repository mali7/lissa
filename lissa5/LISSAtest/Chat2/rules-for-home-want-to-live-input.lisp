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
	(dorm dormitory)
	(patio balcony terrace backyard)
	(modern)
	(instruments piano guitar drum drums)
	(windows)
	(think thought)
	(pool)
	(pet cat dogs)
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
   1 (0 suburb 0) 
        2 ((I like to live in a suburban home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 country 0) 
        2 ((I like to live in a country home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 water 0) 
        2 ((I like to live in a home near water \.)  (home-want-to-live)) (0 :gist) 
   1 (0 luxary 0) 
        2 ((I like to live in a luxary home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 patio 0) 
        2 ((I like to live in a home with patio \.)  (home-want-to-live)) (0 :gist) 
   1 (0 pool 0) 
        2 ((I like to live in a home with pool \.)  (home-want-to-live)) (0 :gist) 
   1 (0 modern 0) 
        2 ((I like to live in a modern home \.)  (home-want-to-live)) (0 :gist) 
   1 (0 instruments 0) 
        2 ((I like to live in a home with instruments in it \.)  (home-want-to-live)) (0 :gist) 
   1 (0 big TV 0) 
        2 ((I like to live in a home with a big TV in it \.)  (home-want-to-live)) (0 :gist) 
   1 (0 big windows 0) 
        2 ((I like to live in a home with big windows \.)  (home-want-to-live)) (0 :gist) 
   1 (0 dorm 0) 
        2 ((I like to live in a dorm room \.)  (home-want-to-live)) (0 :gist) 
   1 (0 house 0) 
        2 ((I like to live in a house \.)  (home-want-to-live)) (0 :gist) 
   1 (0 pet 0) 
        2 ((I like to live in a home with my pets \.)  (home-want-to-live)) (0 :gist) 
   1 (0 have NEG 0 think 0)
        2 ((I have not thought about home I like to live in \.)  (home-want-to-live)) (0 :gist) 
   1 (0 NEG 0 know 0)
        2 ((I have not thought about home I like to live in \.)  (home-want-to-live)) (0 :gist) 
   1 (0 3 0)
        2 ((Nothinf found for where I like to live in \.)  (home-want-to-live)) (0 :gist) 
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
     2 (That is reasonable\. Nice apartments could be found everywhere \.) 
	   (100 :out)
   1 (0 antique 0) 
     2 (Living in an old house would be so cool \.) 
	   (100 :out)
   1 (0 game 0) 
     2 (I should be really into that \.) 
	   (100 :out) 
   1 (0 house 0) 
     2 (That\'s great \. You also love to live in a big house with a big yard \.) 
	   (100 :out)
   1 (0 suburb 0) 
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
   1 (0 dorm 0) 
     2 (Living in dorm would be a cool experience you guess \.) 
	   (100 :out) 
   1 (0 patio 0) 
     2 (You love to live in a house with a patio \.) 
	   (100 :out) 
   1 (0 modern 0) 
     2 (I love a modern house like those kind of intelligent homes \.) 
	   (100 :out) 
   1 (0 instruments 0) 
     2 (So you are into music \.) 
	   (100 :out) 
   1 (0 big tv 0) 
     2 (So you are into watching tv \.) 
	   (100 :out) 
   1 (0 big windows 0) 
     2 (You love house to have a lot of windows \.) 
	   (100 :out) 
   1 (0 pet 0) 
     2 (you love to have a pet but you do not have enought space in my home \.) 
	   (100 :out) 
   1 (0 pool 0) 
     2 (It would be fantastic if I have a pool in my house \.) 
	   (100 :out) 
   1 (0 have not thought 0)
     2 (OK\.) 
	   (100 :out)
   1 (0 3 0)
     2 (That would be nice \!) 
	   (100 :out)   

   )); end of *reaction-to-home-want-to-live-input*

); end of eval-when

