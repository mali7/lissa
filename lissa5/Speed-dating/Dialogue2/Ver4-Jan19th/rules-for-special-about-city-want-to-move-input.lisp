(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((lot lots much)
    (hometown birthplace)
	(family parents)
	(work job company companies working)
	;;(friend friends)
	(weather warm warmer)
	(education graduate baccalaureate school)
	(people lifestyle)
	(apply applied)
	))

;; (why is that city special for you ?)
;;	(special-about-city-want-to-move)
;;		from-special-about-city-input
;;			(The city is special for me because 0)
 
 (READRULES '*specific-answer-from-special-about-city-input*
 '(1 (0 lot 3 to do 0) 
        2 ((The city is special for me because there is a lot of things to do there \. )  (special-about-city-want-to-move)) (0 :gist) 
	1 (0 family 0) 
        2 ((The city is special for me because my family lives there \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 work 0) 
        2 ((The city is special for me because of job opportunities \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 hometown 0) 
        2 ((The city is special for me because that is my hometown \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 friend 0) 
        2 ((The city is special for me because I have friends there \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 education 0) 
	    2 (0 graduate school 0) 
		     3 ((The city is special for me because I want to go to graduate school there \.)  (special-about-city-want-to-move)) (0 :gist) 	
	    2 (0 post baccalaureate 0) 
	         3 ((The city is special for me because I want to do a post baccalaureate program there \.)  (special-about-city-want-to-move)) (0 :gist) 	
        2 (0 postbaccalaureate 0) 
	         3 ((The city is special for me because I want to do a post baccalaureate program there \.)  (special-about-city-want-to-move)) (0 :gist) 	
        2 (0 apply 3 school 0) 
	         3 ((The city is special for me because I want to apply for a school there \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 weather 0) 
        2 ((The city is special for me because the weather is nice there \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 like 2 people 0) 
        2 ((The city is special for me because there are lots of people to meet \.)  (special-about-city-want-to-move)) (0 :gist) 	
    ))
 
 (READRULES '*thematic-answer-from-special-about-city-input*
    '())

 (READRULES '*unbidden-answer-from-special-about-city-input*
	'(1 (0 Cities where I am from 0) 
        2 ((I grew up in the city I want to move to \.)  (hometown)) (0 :gist) 	
   ))

 (READRULES '*question-from-special-about-city-input* 
    '())
 
 (READRULES '*reaction-to-special-about-city-input*  
 '(1 (0 a lot of things to do 0)
      2 (Yeah\, that\'s great to find activities to do in free time \.) 
        (100 :out)
   1 (0 family 0)    
     2 (Yeah\, that\'s great to live near my family \.) 
       (100 :out)
   1 (0 work opportunities 0)    
     2 (That\'s great to have a job there \.) 
       (100 :out)
   1 (0 is my hometown 0)    
     2 (Yeah\, it would be more comfortable to live in hometown than in a new place \.) 
       (100 :out)
   1 (0 have friends 0)    
     2 (This is great that I have friends there \.) 
       (100 :out)
   1 (0 education 0)    
     2 (That is great that I want to continue my study \.) 
       (100 :out)
   1 (0 weather 0)    
     2 (The weather is an important factor in your opinion too \.) 
       (100 :out)
   1 (0 lots of people 0)    
     2 (People and lifestyle are important in your opinion too \.) 
       (100 :out)
      
  )); end of *reaction-to-city-want-to-move-input*

); end of eval-when

