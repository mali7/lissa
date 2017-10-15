(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   ))
   
;; 	Do you have a pet at home?
;;	(have-a-pet)
;; 	from-have-a-pet-input
;;	(0 I do not have a pet 0)  (0 my pet is 0)
;;		gist question: (2 do 1 have 1 pet 3)
	

(READRULES '*specific-answer-from-have-a-pet-input*
   '(
     ))
       
       
 (READRULES '*thematic-answer-from-have-a-pet-input*
    '())

 (READRULES '*unbidden-answer-from-have-a-pet-input*
    '())
		
 (READRULES '*question-from-have-a-pet-input*
    '(1 (0 what 2 you 0)
        2 ( ?) (0 :gist)
      1 (0 how 2 you 0)
        2 ( ?) (0 :gist)
	  1 (0 wh_ 4 hobbies 0)
        2 ( ?) (0 :gist)
      ))

(READRULES '*reaction-to-have-a-pet-input*
   '( 
	))
); end of eval-when
