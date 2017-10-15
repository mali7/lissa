(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((anything nothing)
    (be is being)
	(manager principal chief CEO president chairman head boss)
	(research researcher scientist)
    ))

;; (what is your dream job ?)
;;	(dream-job)
;;		from-dream-job-input
;;			(My dream job is 0)
;;			gist-question:(what 2 dream job 0)
      
 
 (READRULES '*specific-answer-from-dream-job-input*
 '(1 (0 not 1 have 1 job 0) 
        2 ((My dream job is to not have a job \.)  (dream-job)) (0 :gist) 
    1 (0 working in 2 0) 
        2 ((My dream job is working in 4 \.)  (dream-job)) (0 :gist)     
    1 (0 research 0) 
        2 ((My dream job is doing research \.)  (dream-job)) (0 :gist)     
    1 (0 NEG know 0) 
        2 ((I do not know what dream job is \.)  (dream-job)) (0 :gist) 
    1 (0 have no idea 0) 
        2 ((I do not know what my dream job is \.)  (dream-job)) (0 :gist)
    1 (0 have not thought 0) 
        2 ((I do not know what my dream job is \.)  (dream-job)) (0 :gist)
    1 (0 have not given 2 thought 0) 
        2 ((I do not know what my dream job is \.)  (dream-job)) (0 :gist)
    1 (0 manager 0)		
	  2 ((My dream job is to be a principal \.)  (dream-job)) (0 :gist)
	1 (0 3 0)		
	  2 ((nothing found for what my dream job is \.)  (dream-job)) (0 :gist)
	))
 
 (READRULES '*thematic-answer-from-dream-job-input*
    '())

 (READRULES '*unbidden-answer-from-dream-job-input*
    '())

 (READRULES '*question-from-dream-job-input* 
    '( ; we answer the reciprocal question in the next say action 
	))
 
 (READRULES '*reaction-to-dream-job-input*  
 '(1 (0 not have a job 0) 
     2 (You would plan a round the world trip if you did not have to work \. However \,) 
	   (100 :out) 
   1 (0 research 0) 
     2 (Doing reaserch would be so cool \.) 
	   (100 :out) 
   1 (0 do not know 0) 
     2 (OK \.) 
	   (100 :out) 
   1 (0 manager 0) 
     2 (That\'s interesting \.) 
	   (100 :out) 	   
   1 (0 working in 0) 
     2 (That would be an interesting experience \.) 
	   (100 :out) 
   1 (0 3 0) 
     2 (That\'s nice \.) 
	   (100 :out) 
   )); end of *reaction-to-dream-job-input*

); end of eval-when

