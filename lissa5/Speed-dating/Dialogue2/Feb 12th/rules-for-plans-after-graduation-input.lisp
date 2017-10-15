(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((anything nothing)
    (plan plans)
	(graduate grad graduation graduated )
	(do doing)
	(get getting)
    ))

;; (what are your plans after you graduate ?)
;;	(plans-after-graduation)
;;		from-plans-after-graduation-input
;;			(My plan after graduation is 0)
;;			gist-question: (what 0 plans after 1 graduate 0)
      
 
 (READRULES '*specific-answer-from-plans-after-graduation-input*
 '(1 (0 graduate school 0) 
        2 ((My plan after graduation is going to graduate school \.)  (plans-after-graduation)) (0 :gist)  
   1 (0 postbaccalaureate 0) 
	    2 ((My plan after graduation is doing a post baccalaureate program \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 post baccalaureate 0) 
	    2 ((My plan after graduation is doing a post baccalaureate program \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 get 1 master 0) 
	    2 ((My plan after graduation is getting my master degree \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 get 1 PhD 0) 
	    2 ((My plan after graduation is getting my PhD \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 get 1 work 0) 
	    2 ((My plan after graduation is getting a job \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 do 2 fellowship 0) 
	    2 ((My plan after graduation is doing a fellowship \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 work in 0) 
	    2 ((My plan after graduation is getting a job \.)  (plans-after-graduation)) (0 :gist) 	
   1 (0 3 0) 
	    2 ((Nothing found for what my plan after graduation is getting a job \.)  (plans-after-graduation)) (0 :gist) 	
   ))
 
 (READRULES '*thematic-answer-from-plans-after-graduation-input*
    '())

 (READRULES '*unbidden-answer-from-plans-after-graduation-input*
	'())

 (READRULES '*question-from-plans-after-graduation-input* 
    '(1 (0 what 0 you 0)
        2 (what are your plans after you graduate ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what are your plans after you graduate ?) (0 :gist)
      1 (0 what 2 your plan 2 graduate 0)
        2 (what are your plans after you graduate ?) (0 :gist)
      1 (0 what 2 you 2 do 2 graduate 0)
        2 (what are your plans after you graduate ?) (0 :gist)	 
    ))
 
 (READRULES '*reaction-to-plans-after-graduation-input*  
 '(1 (0 going to graduate school 0) 
     2 (So I want to do research in my major \.) 
	   (100 :out) 
   1 (0 post baccalaureate 0) 
     2 (PBS would definitely improve your knowledge in your major \.) 
	   (100 :out) 
   1 (0 getting 1 master 0) 
     2 (A master degree could increase my chance for getting better jobs \.) 
	   (100 :out) 
   1 (0 getting 1 PhD 0) 
     2 (So I want to do research in my major \.) 
	   (100 :out) 
   1 (0 doing 1 fellowship 0) 
     2 (That would be excellent if I do a fellowship in your field of study \.) 
	   (100 :out)
   1 (0 getting 1 PhD 0) 
     2 (So I want to do research in my major \.) 
	   (100 :out) 
   1 (0 getting 1 job 0) 
     2 (Sounds reasonable \.) 
	   (100 :out) 
   1 (0 3 0) 
     2 (Sounds reasonable \.) 
	   (100 :out) 
      
   )); end of *reaction-to-plans-after-graduation-input*

); end of eval-when

