(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((rochester-restaurant-t Tahou Tahou\'s  plate Barbecue Luck Rosita\'s town star)
	(restaurant-type restaurant-type-one restaurant-type-two)
    (restaurant-type-one Chinese Mexican Japanese Italian Korean Peruvian Thai Ethiopian Indian Mediterranean) 
    (restaurant-type-two burger pizza grill grills) 
	(restaurant-type-three diner cafe)))
    
; phrases for gist extraction:

 (READRULES '*specific-answer-from-favorite-eatery-in-rochester-input*
   '(1 (0 rochester-restaurant rochester-restaurant-t 0)
       2 ((My favorite restaurant is 2 3 \.) (Rochester-eateries)) (0 :gist)
     1 (0 rochester-restaurant 0)
       2 ((My favorite restaurant is 2 \.) (Rochester-eateries)) (0 :gist)
     1 (0 restaurant-type 0)
        2 ((My favorite kind of restaurant is 2 \.) (Rochester-eateries)) (0 :gist)
	 1 (0 3 0)
        2 ((Nothing found about my favorite restaurant \.) (Rochester-eateries)) (0 :gist)	
	))
       
       
 (READRULES '*thematic-answer-from-favorite-eatery-in-rochester-input*
    '())

 (READRULES '*unbidden-answer-from-favorite-eatery-in-rochester-input*
    '(1 (0 dinosaur 0)
        2 ((I have been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
      1 (0 garbage plate 0)
        2 ((I have had a garbage plate \.) (garbage-plate)) (0 :gist)
      1 (0 Nick Tahou\'s 0)
        2 ((I have had a garbage plate \.) (garbage-plate)) (0 :gist)
      1 (0 Steve T\'s 0)
        2 ((I have had a garbage plate \.) (garbage-plate)) (0 :gist)))
		
 (READRULES '*question-from-favorite-eatery-in-rochester-input*
    '(1 (0 wh_ 1 you 0)
        2 (What is your favorite eatery in Rochester ?) (0 :gist)
      1 (0 you heard 0)
        2 (Have you heard of that restaurant ?) (0 :gist)
      1 (0 you been 0)
        2 (Have you been to that restaurant ?) (0 :gist)))

(READRULES '*reaction-to-favorite-eatery-in-rochester-input*
   '(1 (0 restaurant-type 0)
       2 (0 restaurant-type-one 0)  ;; international
        3 (That\'s great\. You like 2 food \.) (100 :out)
       2 (0 restaurant-type-two 0)  ;; grill pizza etc
        3 (0 grill 0)
		 4 (You are actually a fan of grills \.) (100 :out) 
		3 (You are actually a fan of 2 \.) (100 :out)
       2 (0 restaurant-type-three 0) ;; 
        3 (You like that kind of food too\.) (100 :out); end of *reaction-to-restaurant-input*
	 1 (0 rochester-restaurant 0)
       2 (You have not been there\, but it sounds nice\.) (100 :out)
     1 (0 Nothing found 0)
       2 (You love to experience new places and new tastes\.) (100 :out)
	))
); end of eval-when
