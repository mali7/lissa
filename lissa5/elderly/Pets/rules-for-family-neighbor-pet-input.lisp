(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  
  ))
   
;; 	Tell me about a pet of a family member or neighbor
;;	family-neighbor-pet
;;	(0 my family member has a pet 0) (0 my neighbor has a pet 0)
;;		gist question: (1 Tell me about 2 pet 3 family 2 neighbor 3) 

	
(READRULES '*specific-answer-from-family-neighbor-pet-input*
  '(
  1 (0 ? 0)
     2 ((Gist \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (family-neighbor-pet)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-family-neighbor-pet-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-family-neighbor-pet-input*
  '(

  ))
		
 (READRULES '*question-from-family-neighbor-pet-input*
  '(
  1 (0 what 2 you 0)
     2 (Tell me about a pet of a family member or neighbor) (0 :gist)
  1 (0 how 2 you 0)
     2 (Tell me about a pet of a family member or neighbor) (0 :gist)
	1 (0 ? 0)
     2 (Tell me about a pet of a family member or neighbor) (0 :gist)
  ))

(READRULES '*reaction-to-family-neighbor-pet-input*
  '( 
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
	))
); end of eval-when
