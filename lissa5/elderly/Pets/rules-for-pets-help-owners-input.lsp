(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))

;;	How do pets help their owners?
;;	pets-help-owners
;;	(0 I belive pets help their owners 0)
;;	from-pets-help-owners-input
;;		gist question: (1 how 2 pets help 3)

	
(READRULES '*specific-answer-from-pets-help-owners-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-pets-help-owners-input*
    '())

 (READRULES '*unbidden-answer-from-pets-help-owners-input*
    '())
		
 (READRULES '*question-from-pets-help-owners-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-pets-help-owners-input*
   '( 
	))
); end of eval-when
