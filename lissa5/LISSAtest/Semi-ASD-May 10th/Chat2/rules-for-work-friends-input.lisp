(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((anything nothing)
    ))

;; (what do you think about work friends ?)
;;	(work-friends)
;;		from-work-friends-input
;;			(I think work friends 0)
      
 
 (READRULES '*specific-answer-from-work-friends-input*
 '(1 (0) 
        2 ((I told you what I think about work friends \.)  (work-friends)) (0 :gist) 
    ))
 
 (READRULES '*thematic-answer-from-work-friends-input*
    '())

 (READRULES '*unbidden-answer-from-work-friends-input*
	())

 (READRULES '*question-from-work-friends-input* 
    '())
 
 (READRULES '*reaction-to-work-friends-input*  
 '(1 (0 3 0)
    2 (Right\, You agree\.) (100 :out))); end of *reaction-to-work-friends-input*

); end of eval-when

