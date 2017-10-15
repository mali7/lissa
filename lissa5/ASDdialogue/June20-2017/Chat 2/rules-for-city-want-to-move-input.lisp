(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((popular-Cities North-Eastern-Cities Northern-Cities North-Western-Cities South-Western-Cities Southern-Cities Western-Cities) 
    (less-popular-Cities South-to-Rochester Central-Cities)
	(Northern-Cities Chicago Indianapolis Columbus Detroit Cleveland)
	(North-Western-Cities Seattle)
	(South-Western-Cities Phoenix)
	(Southern-Cities Houston Dallas Austin Miami)
	(Western-Cities LA Francisco)
	(Eastern-Cities Boston NYC Philadelphia Washington Baltimore Manhathan Brooklyn)
	(South-to-Rochester Atlanta Charlotte)
	(Central-Cities Memphis Denver Kansas)
    (popular-States California Florida Massachusetts Ohio Texas Pennsylvania Maryland Virginia Colorado Vermont)
    (stay staying)
	(Rochester here)
	(think thought)
	(allcities)
	(grow grown grew raised)
	(lot lots much)
    (hometown birthplace)
	(family parents)
	(weather warm warmer)
	(people lifestyle)
	(apply applied)
	(like love)   ;; check it
	))

;; (what city would you want to move to next ?)
;;	(city-want-to-move)
;;		*...-from-city-want-to-move-input*
;;			(I want to move to 0)
;;			(I want 0 stay here 0)
;;			gist-question: (what city 0 want to move 0)
      
 
 (READRULES '*specific-answer-from-city-want-to-move-input*
 '(1 (0 New York 0) 
        2 ((I want to move to New York City \.)  (city-want-to-move)) (0 :gist)
   1 (0 Los Angeles 0) 
        2 ((I want to move to 2 3 \.)  (city-want-to-move)) (0 :gist) 
   1 (0 San Antonio 0) 
        2 ((I want to move to 2 3 \.)  (city-want-to-move)) (0 :gist) 
   1 (0 San Jose 0) 
        2 ((I want to move to 2 3 \.)  (city-want-to-move)) (0 :gist) 
   1 (0 San Diego 0) 
        2 ((I want to move to 2 3 \.)  (city-want-to-move)) (0 :gist) 
   1 (0 popular-Cities 0) 
        2 ((I want to move to 2 \.)  (city-want-to-move)) (0 :gist) 
   1 (0 popular-States 0) 
        2 ((I want to move to 2 \.)  (city-want-to-move)) (0 :gist) 		
   1 (0 stay 2 Rochester 0) 
        2 ((I want to stay here in Rochester \.)  (city-want-to-move)) (0 :gist) 		
   1 (0 stay 2 here 0) 
        2 ((I want to stay here in Rochester \.)  (city-want-to-move)) (0 :gist) 		
   1 (0 NEG 2 think 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 haven\'t 2 think 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 NEG 2 decided 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 haven\'t 2 decided 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 NEG 2 know 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 don\'t 2 know 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 have NEG given 2 thought 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 haven\'t given 2 thought 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 have no idea 0)
        2 ((I do not know where I want to move to \.)  (city-want-to-move)) (0 :gist) 
   1 (0 big city 0)
        2 ((I want to move to a big city \.)  (city-want-to-move)) (0 :gist) 
   1 (0 3 0)
        2 ((Nothing found for I want to move to \.)  (city-want-to-move)) (0 :gist) 
	))
	
 (READRULES '*thematic-answer-from-city-want-to-move-input*
    '(1 (0 I 3 grow 6 Cities 0)
        2 ((I grew up in 6 \.)  (hometown)) (0 :gist) 
	  1 (0 I 3 born 6 Cities 0)
        2 ((I grew up in 6 \.)  (hometown)) (0 :gist) 
	  1 (0 I 4 from 6 Cities 0)
        2 ((I grew up in 5 \.)  (hometown)) (0 :gist) 
	  1 (0 it is my hometown 0)
        2 ((I grew up in the city I want to move \.)  (hometown)) (0 :gist) 
	  1 (0 it is my home 0)
        2 ((I grew up in the city I want to move \.)  (hometown)) (0 :gist) 
	  ))

 (READRULES '*unbidden-answer-from-city-want-to-move-input*
	'(1 (0 I 3 grow 6 Cities 0)
        2 ((The city is special for me because that is my hometown \.)  (special-about-city-want-to-move)) (0 :gist) 
	  1 (0 I 3 born 6 Cities 0)
        2 ((The city is special for me because that is my hometown \.)  (special-about-city-want-to-move)) (0 :gist) 
	  1 (0 I 4 from 6 Cities 0)
        2 ((The city is special for me because that is my hometown \.)  (special-about-city-want-to-move)) (0 :gist) 
	  1 (0 it is my hometown 0)
        2 ((The city is special for me because that is my hometown \.)  (special-about-city-want-to-move)) (0 :gist) 
	  1 (0 it is my home 0)
        2 ((The city is special for me because that is my hometown \.)  (special-about-city-want-to-move)) (0 :gist) 
      1 (0 lot 2 to do 0) 
        2 ((The city is special for me because there is a lot of thongs to do there \. )  (special-about-city-want-to-move)) (0 :gist) 
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
	         3 ((The city is special for me because I want to continue my study there \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 weather 0) 
        2 ((The city is special for me because the weather is nice there \.)  (special-about-city-want-to-move)) (0 :gist) 	
    1 (0 like 4 people 0) 
        2 ((The city is special for me because there are lots of people to meet \.)  (special-about-city-want-to-move)) (0 :gist) 	
	1 (0 NEG 2 think 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 haven\'t 2 think 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 NEG 2 decided 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 haven\'t 2 decided 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 NEG 2 know 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 don\'t 2 know 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 have NEG given 2 thought 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 haven\'t given 2 thought 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 have no idea 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
   1 (0 have NEG given 2 thought 0)
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
    1 (0 stay 2 Rochester 0) 
        2 ((There can not be an answer for why the city is special for me \.)  (special-about-city-want-to-move)) (0 :gist) 
	1 (0 because 8 0) 
        2 ((The reason why the city is special for me is 3 \.)  (special-about-city-want-to-move)) (0 :gist) 
	
    1 (0 New York City where I am from 0) 
        2 ((I grew up in 2 3 4 \.)  (hometown)) (0 :gist)
   1 (0 Los Angeles where I am from 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Antonio where I am from 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Jose where I am from 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Diego where I am from 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 Cities where I am from 0) 
        2 ((I grew up in 2 \.)  (hometown)) (0 :gist) 	
   

   1 (0 I am from 6 New York City 0) 
        2 ((I grew up in 2 3 4 \.)  (hometown)) (0 :gist)
   1 (0 I am from 6 Los Angeles 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I am from 6 San Antonio 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I am from 6 San Jose 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I am from 6 San Diego 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I am from 6 Cities 0) 
        2 ((I grew up in 2 \.)  (hometown)) (0 :gist) 	

    1 (0 New York City where I grew up 0) 
        2 ((I grew up in 2 3 4 \.)  (hometown)) (0 :gist)
   1 (0 Los Angeles where I grew up 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Antonio where I grew up 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Jose where I grew up 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 San Diego where I grew up 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 Cities where I grew up 0) 
        2 ((I grew up in 2 \.)  (hometown)) (0 :gist) 	
  

   1 (0 I grew up in 6 New York City 0) 
        2 ((I grew up in 2 3 4 \.)  (hometown)) (0 :gist)
   1 (0 I grew up in 6 Los Angeles 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I grew up in 6 San Antonio 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I grew up in 6 San Jose 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I grew up in 6 San Diego 0) 
        2 ((I grew up in 2 3 \.)  (hometown)) (0 :gist) 
   1 (0 I grew up in 6 Cities 0) 
        2 ((I grew up in 2 \.)  (hometown)) (0 :gist) 	

    ))

 (READRULES '*question-from-city-want-to-move-input* 
    '(1 (0 what 0 you 0)
        2 (what city do you want to move to ?) (0 :gist)
      1 (0 what city 0 you 0 move 0)
        2 (what city do you want to move to ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what city do you want to move to ?) (0 :gist)
     ))
    
 (READRULES '*reaction-to-city-want-to-move-input*  
 '(1 (0 I want to move to 0)    
	  2 (0 New York 0)
        3 (Cool\, a lot of people like to live in New York City \.)  ;; 3 (So you prefer to live in the west coast \.)
          (100 :out)
      2 (0 Los Angeles 0)
        3 (Cool\, Los Angeles has lots of attractions \.)
          (100 :out)
      2 (0 San Antonio 0)
        3 (So I prefer to live in the west coast \.)
          (100 :out)
      2 (0 San Jose 0)
        3 (So I prefer to live in the west coast \.)
          (100 :out)
      2 (0 San Diego 0)
        3 (Oh\, San Diego is definitely much warmer than Rochester \.)
          (100 :out)
	  2 (0 popular-Cities 0)
	    3 (0 Eastern-Cities 0)
		  4 (East coast is a great place to live \.) 
		    (100 :out)
		3 (0 Northern-Cities 0)
		  4 (Oh\, 2 is even colder than Rochester \.) 
		    (100 :out)
		3 (0 North-Western-Cities 0)
		  4 (Oh\, you haven\'t been there but 2 seems like a cool place to live \.) 
		    (100 :out)
		3 (0 South-Western-Cities 0)
		  4 (Oh\, you haven\'t been there but I know that 2 is much warmer than Rochester \.)  
		    (100 :out)
		3 (0 Southern-Cities 0)
		  4 (0 Miami 0)
		    5 (Oh\, you haven\'t been there but you love to go to Florida some time \.) 
		      (100 :out)
		  4 (0)
		    5 (Oh\, you haven\'t been there but you love to go to Texas some time \.) 
		      (100 :out)	 
		3 (0 Western-Cities 0)
		  4 (So I prefer to live in the west coast \.) 
		    (100 :out)
		3 (0 South-to-Rochester 0)
		  4 (It is good that you would experience warmer weather in 2 \.) 
		    (100 :out)
		3 (0 Central-Cities 0)
		  4 (Oh\, you haven\'t been there but 2 seems like a cool place to live \.) 
		    (100 :out)
	  2 (0 popular-States 0)
	    3 (0 California 0)
		  4 (West coast is a great place to live \.) 
		    (100 :out)
		3 (0 Florida 0)
		  4 (You love to go to Florida beaches some time \.) 
		    (100 :out)
		3 (0 Massachusetts 0)
		  4 (Oh\, 2 is even colder than Rochester \.)  
		    (100 :out)
		3 (0 Texas 0)
		  4 (Oh\, you haven\'t been there but you love to go to Texas some time \.)
		    (100 :out)
		3 (0 Colorado 0)
		  4 (You haven't been in 2 but I love the state because of it\'s beautiful landscapes \.) 
		    (100 :out)
		3 (0 Vermont 0)
		  4 (You haven't been in 2 but I love the state because of it\'s nature \.)
            (100 :out)		  
		3 (0)  ;; Ohio Maryland Pennsylvania Virginia
		  4 (Cool\, you haven\'t been there yet \.) 
		    (100 :out)
	  2 (0 big city 0)
	    3 (You would love to live in a big city for a while but not probably for your whole life \.) 
		    (100 :out)
	1 (0 I want to stay here 0)
      2 (Oh\, That\'s cool that I am happy with living in Rochester \.) 
        (100 :out)
	1 (0 I do NEG know 0)
      2 (So I need to think more about it \.) 
        (100 :out)
    1 (0 3 0)
      2 (Oh\, That\'s cool\.) 
        (100 :out)	
     	)); end of *reaction-to-city-want-to-move-input*

); end of eval-when

