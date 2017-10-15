(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((anything nothing)
    (weather climate warm warmer cold colder snow hot hotter humid)
	(lot lots much)
	(social-environment people community social)
	(neighborhood neighbor)
	(social poor poverty prosperity getto crime)
	(nature green forest)
	(sleep sleeps sleeping)
    ))

;; ((what is the biggest difference between your hometown and Rochester ?)
;;	(Rochester-hometown-difference)
;;		from-rochester-hometown-difference-input
;;			(The biggest difference between my hometown and Rochester is 0)
      
 
 (READRULES '*specific-answer-from-rochester-hometown-difference-input*
 '(1 (0 weather 0) 
        2 ((The biggest difference between my hometown and Rochester is the weather \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 lot 2 to do 0)
        2 ((The biggest difference between my hometown and Rochester is that there was a lot to do \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 things 2 to do 0)
        2 ((The biggest difference between my hometown and Rochester is that there was a lot to do \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 always 1 things 2 going on 0)
        2 ((The biggest difference between my hometown and Rochester is that there was a lot to do \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 always 1 have activity 2 do 0)
        2 ((The biggest difference between my hometown and Rochester is that there was a lot to do \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 never 1 sleep 0)
        2 ((The biggest difference between my hometown and Rochester is that there was a lot to do \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 neighborhood 0) 
        2 ((The biggest difference between my hometown and Rochester is the neighborhood \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 social-environment 0) 
        2 ((The biggest difference between my hometown and Rochester is the social-environment \.)  (rochester-hometown-difference)) (0 :gist) 
    1 (0 3 0) 
        2 ((Nothing found for what is the biggest difference between my hometown and Rochester \.)  (rochester-hometown-difference)) (0 :gist) 
     
 ))
 
 (READRULES '*thematic-answer-from-rochester-hometown-difference-input*
    '())

 (READRULES '*unbidden-answer-from-rochester-hometown-difference-input*
	'(1 (0 what do you think 0)
        2 (what is the biggest difference between your hometown and Rochester ?) (0 :gist)
      1 (0 what 3 is the biggest difference between 3 hometown 2 Rochester 0)
        2 (what is the biggest difference between your hometown and Rochester ?) (0 :gist)
     ))

 (READRULES '*question-from-rochester-hometown-difference-input* 
    '(1 (0 what 0 you 0)
        2 (what are your plans after you graduate ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what are your plans after you graduate ?) (0 :gist)
      1 (0 what 2 your plan 2 graduate 0)
        2 (what are your plans after you graduate ?) (0 :gist)
      1 (0 what 2 you 2 do 2 graduate 0)
        2 (what are your plans after you graduate ?) (0 :gist)	 
    ))
 
 (READRULES '*reaction-to-rochester-hometown-difference-input*  
 '(1 (0 weather 0) 
     2 (Yeah\, Rochester is one of the coldest places that you have ever been \.) 
	   (100 :out) 
   1 (0 a lot to do 0) 
     2 (Yeah\, there are always a lot of things to do in larger cities \.) 
	   (100 :out) 
   1 (0 social-environment 0) 
     2 (So you would experience a different social environment here \.) 
	   (100 :out) 
   1 (0 neighborhood 0) 
     2 (So you would experience a different neighborhood here \.) 
	   (100 :out) 
   1 (0 3 0) 
     2 (Right \.) 
	   (100 :out) 
   )); end of *reaction-to-rochester-hometown-difference-input*

); end of eval-when

