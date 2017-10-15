(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((anything nothing)
    (yes yeah)
	))

;; (do you stay in touch with any of your friends from home ?)
;;	(friends-from-home)
;;		from-friends-from-home-input
;;			(I am not in touch with my friends from home 0)
;;			(I am in touch with my friends from home 0)
      
 
 (READRULES '*specific-answer-from-friends-from-home-input*
 '(1 (0 yes 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 I 1 do 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 I stay 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 we are in touch 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 I am in touch 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 quite a few 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 lot 1 them 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 most 1 them 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 lot 4 friends 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 most 4 friends 0) 
        2 ((I am in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 no 0) 
        2 ((I am not in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 
   1 (0 NEG 1 in touch 0) 
        2 ((I am not in touch with my friends from home \.)  (friends-from-home)) (0 :gist) 		
    ))
 
 (READRULES '*thematic-answer-from-friends-from-home-input*
    '())

 (READRULES '*unbidden-answer-from-friends-from-home-input*
	'())

 (READRULES '*question-from-friends-from-home-input* 
    '(1 (0 what 0 you 0)
        2 (do you stay in touch with any of your friends from home ?) (0 :gist)
      1 (0 do you stay in touch 0 home 0)
        2 (do you stay in touch with any of your friends from home ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (do you stay in touch with any of your friends from home ?) (0 :gist)
    ))
 
 (READRULES '*reaction-to-friends-from-home-input*  
 '(1 (0 not in touch 0) 
     2 (You understand \.) 
	   (100 :out) 
   1 (0 am in touch 0) 
     2 (That\'s great that I have contact with your home friends \.) 
	   (100 :out) 
   1 (0) 
     2 (You understand \.) 
	   (100 :out) 
   )); end of *reaction-to-friends-from-home-input*

); end of eval-when

