(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))

;; How one can cope with giving up driving ?   
;;	(0 way 1 cope with giving up driving 0)
;;	giving-up-driving
;;	(1 how 2 cope 1 giving up driving 3)

(READRULES '*specific-answer-from-giving-up-driving-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-giving-up-driving-input*
    '())

 (READRULES '*unbidden-answer-from-giving-up-driving-input*
    '())
		
 (READRULES '*question-from-giving-up-driving-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-giving-up-driving-input*
   '( 
	))
); end of eval-when
