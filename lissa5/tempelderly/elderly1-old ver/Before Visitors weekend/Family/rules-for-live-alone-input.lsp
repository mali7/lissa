(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((live living)
    (spouse husband wife)
   ))
;; (Do you live by yourself or with others ?)
;;	(live-alone)
;;		from-live-alone-input
;;			(0 I live by myself 0) (0 I live with  0)
;;			gist-question:(3 do you live 2 yourself 0)

 (READRULES '*specific-answer-from-live-alone-input*
   '(1 (0 live by myself 0) 
        2 ((I live by myself \.)  (live-alone)) (0 :gist) 		
     1 (0 live alone 0) 
        2 ((I live by myself \.)  (live-alone)) (0 :gist) 		
     1 (0 live 2 spouse 0) 
        2 ((I live with my spouse \.)  (live-alone)) (0 :gist) 		
     1 (0 spouse 3 live 0) 
        2 ((I live with my spouse \.)  (live-alone)) (0 :gist) 		
     1 (0 live 2 partner 0) 
        2 ((I live with my partner \.)  (live-alone)) (0 :gist) 		
     1 (0 live 2 children 0) 
        2 ((I live with my children \.)  (live-alone)) (0 :gist) 		
     1 (0 children 3 live 0) 
        2 ((I live with my children \.)  (live-alone)) (0 :gist) 		
     1 (0 live 2 mother 0) 
        2 ((I live with my mother \.)  (live-alone)) (0 :gist) 		
     1 (0 mother 3 live 0) 
        2 ((I live with my mother \.)  (live-alone)) (0 :gist) 		
     ))
       
       
 (READRULES '*thematic-answer-from-live-alone-input*
    '())

 (READRULES '*unbidden-answer-from-live-alone-input*
    '())
		
 (READRULES '*question-from-live-alone-input*
    '(1 (0 what 2 you 0)
        2 (do you live by yourself ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (do you live by yourself ?) (0 :gist)
	  1 (0 do you live 0)
        2 (do you live by yourself ?) (0 :gist)
      ))

(READRULES '*reaction-to-live-alone-input*
   '(1 (0 myself 0)	
       2 (Lots of people live alone\. There are good things about having my own space\.) (100 :out)
     1 (0 spouse 0)
       2 (It\'s good we live together and can look out for each other\.) (100 :out)
     1 (0 partner 0)
       2 (It\'s good we live together and can look out for each other\.) (100 :out)
     1 (0 children 0)
       2 (It\'s good to live with my children\. They must be nice\.) (100 :out)
     1 (0 mother 0)
       2 (That\'s nice\.) (100 :out)
	))
); end of eval-when
