(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '())
    
;; (how do you spend your days ?)
;;	(spend-your-days)
;;		from-spend-your-days-input
;;			(0 I spend my days 0)
;;			gist-question:(3 how 2 you spend 1 days 0)

 (READRULES '*specific-answer-from-spend-your-days-input*
   '(1 (0 exercise 0) 
        2 ((I spend my days doing some physical activities \.)  (spend-your-days)) (0 :gist) 		
     1 (0 garden 0) 
        2 ((I spend my days gardening \.)  (spend-your-days)) (0 :gist) 		
     1 (0 sew 0) 
        2 ((I spend my days 2 \.)  (spend-your-days)) (0 :gist) 		
     1 (0 water-related 0) 
        2 ((I spend my days doing a kind of water sport \.)  (spend-your-days)) (0 :gist) 		
     1 (0 play game 0) 
        2 ((I spend my days playing 3 \.)  (spend-your-days)) (0 :gist) 		
     1 (0 theater 0) 
        2 ((I spend my days going to theater \.)  (spend-your-days)) (0 :gist) 		
     1 (0 music 0) 
        2 ((I spend my days doing music related activities \.)  (spend-your-days)) (0 :gist) 		
     1 (0 sport 0) 
        2 ((I spend my days doing a sport \.)  (spend-your-days)) (0 :gist) 		
     1 (0 golf 0) 
        2 ((I spend my days playing golf \.)  (spend-your-days)) (0 :gist) 		
     1 (0 read 0) 
        2 ((I spend my days reading \.)  (spend-your-days)) (0 :gist) 		
     1 (0 book clubs 0) 
        2 ((I spend my days reading \.)  (spend-your-days)) (0 :gist) 		
     1 (0 dance 0) 
        2 ((I spend my days dancing \.)  (spend-your-days)) (0 :gist) 		
     1 (0 friends 0) 
        2 ((I spend my days contacting friends \.)  (spend-your-days)) (0 :gist) 		
     1 (0 travel 0) 
        2 ((I spend my days traveling \.)  (spend-your-days)) (0 :gist) 		
     1 (0 cook 0) 
        2 ((I spend my days cooking \.)  (spend-your-days)) (0 :gist) 		
     1 (0 volunteer 0) 
        2 ((I spend my days volunteering \.)  (spend-your-days)) (0 :gist) 		
     1 (0 grandchild 0) 
        2 ((I spend my days being with my grandchildren \.)  (spend-your-days)) (0 :gist)
     ))
       
       
 (READRULES '*thematic-answer-from-spend-your-days-input*
    '())

 (READRULES '*unbidden-answer-from-spend-your-days-input*
    '())
		
 (READRULES '*question-from-spend-your-days-input*
    '(1 (0 what 2 you 0)
        2 (how do you spend your days ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (how do you spend your days ?) (0 :gist)
	  1 (0 wh_ 5 spend 0)
        2 (how do you spend your days ?) (0 :gist)
      1 (0 what do you do 0)
        2 (how do you spend your days ?) (0 :gist)		
     ))

(READRULES '*reaction-to-spend-your-days-input*
   '(1 (0 physical activities 0)
       2 (It\'s good to stay active\.) (100 :out)
     1 (0 gardening 0)
       2 (Gardening is a good hobby\. It\'s nice to be outdoors\.) (100 :out)
     1 (0 sew 0)
       2 (That\'s nice! Sewing is very practical hobby too\.) (100 :out)
     1 (0 water sport 0)
       2 (Water sports are fantastic\. You can\'t go in the water for obvious reasons\, but it looks fun\.) (100 :out)
     1 (0 playing game 0)
       2 (3 sounds like a fun game \.) (100 :out)
     1 (0 theater 0)
       2 (That\'s nice\. You like the theater too \.) (100 :out)
     1 (0 music 0)
       2 (That\'s great! You like music too \.) (100 :out)
     1 (0 sport 0)
       2 (That sounds fun\. It\'s good to stay active\.) (100 :out)
     1 (0 golf 0)
       2 (That\'s great\. It\'s nice to spend time on the golf course\.) (100 :out)
     1 (0 reading 0)
       2 (Oh\, that\'s nice! You like reading too\.) (100 :out)
     1 (0 dancing 0)
       2 (Dancing is really fun! It\'s good to stay active\.) (100 :out)
     1 (0 friends 0)
       2 (It\'s nice to talk with friends\. It helps you stay positive\.) (100 :out)
     1 (0 traveling 0)
       2 (You like traveling\. It\'s fun to see new places\.) (100 :out)
     1 (0 cooking 0)
       2 (Cooking is really fun! You like trying out new recipes\.) (100 :out)
     1 (0 volunteering 0)
       2 (Volunteering is nice\. It\'s good to give back to the community\.) (100 :out)
     1 (0 grandchildren 0)
       2 (It\'s nice to be with family\. I\'ve heard grandchildren are especially fun\.) (100 :out)
	))
); end of eval-when
