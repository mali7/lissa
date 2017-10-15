(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((anything nothing)
    ;(friend friends)
	(family parents)
	(neighborhood)
	(go going)
	(beach beaches)
	(hiking trails forest)
    ))

;; (what do you miss about your hometown ?)
;;	(miss-about-hometown)
;;		from-miss-about-hometown-input
;;			(What I missed about my hometown is 0)	
      
 
 (READRULES '*specific-answer-from-miss-about-hometown-input*
 '(1 (0 beach 0)
	    2 ((What I missed about my hometown is the beaches \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 family 0) 
        2 ((What I missed about my hometown is my family \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 lot 2 things 2 to do 0) 
        2 ((What I missed about my hometown is that there were lots of things to do \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 do 1 lot things 0)
	    2 ((What I missed about my hometown is that there were lots of things to do \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 go out 0) 
        2 ((What I missed about my hometown is being able to go to lots of places \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 go 7 places 0)
	    2 ((What I missed about my hometown is being able to go to lots of places \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 neighborhood 0) 
        2 ((What I missed about my hometown is the neighborhood \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 hiking 0) 
        2 ((What I missed about my hometown is being able to go hiking \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 freedom 0) 
        2 ((What I missed about my hometown is the freedom I had there \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 friend 0) 
        2 ((What I missed about my hometown is my friends \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 food 0) 
        2 ((What I missed about my hometown is the food \.)  (miss-about-hometown)) (0 :gist) 
   1 (0 house 0)
	    2 ((What I missed about my hometown is my house \.)  (miss-about-hometown)) (0 :gist) 
	))
 
 (READRULES '*thematic-answer-from-miss-about-hometown-input*
    '())

 (READRULES '*unbidden-answer-from-miss-about-hometown-input*
	())

 (READRULES '*question-from-miss-about-hometown-input* 
    '())
 
 (READRULES '*reaction-to-miss-about-hometown-input*  
 '()); end of *reaction-to-miss-about-hometown-input*

); end of eval-when

