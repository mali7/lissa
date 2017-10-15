(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((first-per-pron I we)
  (child children son daughter sons daughters)
  (grandchild grandchildren grandkid grandkids grandson granddaughter grandsons granddaughters)))
;; (Do you have children or grandchildren ?)
;;	(children)
;;		from-children-input
;;			(0 I have 2 children 0) (I have 2 grandchildren  0)
;;			gist-question:(3 do you have children 0)

 (READRULES '*specific-answer-from-children-input*
   '(1 (0 first-per-pron have 1 child 0) 
        2 ((I have 4 children \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have 1 child 0) 
        2 ((I have 4 children \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have 1 child 0) 
        2 ((I have 4 grandchild \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have 4 grandchild 0) 
        2 ((I have grandchildren \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have 4 grandchild 0) 
        2 ((I have grandchildren \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have 4 grandchild 0) 
        2 ((I have grandchildren \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have no child 0) 
        2 ((I have no children \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron do not have 1 child 0) 
        2 ((I have no children \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron don\'t have 1 child 0) 
        2 ((I have no children \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron have no grandchild 0) 
        2 ((I have no grandchildren \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron do not have 4 grandchild 0) 
        2 ((I have no grandchildren \.)  (children)) (0 :gist) 		
     1 (0 first-per-pron don\'t have 4 grandchild 0) 
        2 ((I have no grandchildren \.)  (children)) (0 :gist) 		
     1 (0 my child 0) 
        2 ((I have children \.)  (children)) (0 :gist) 		
     1 (0 my grandchild 0) 
        2 ((I have grandchildren \.)  (children)) (0 :gist) 		
     1 (NEG 0) 
        2 ((I have no children \.)  (children)) (0 :gist) 		
     ))
       
       
 (READRULES '*thematic-answer-from-children-input*
    '())

 (READRULES '*unbidden-answer-from-children-input*
    '())
		
 (READRULES '*question-from-children-input*
    '(1 (0 what 2 you 0)
        2 (do you have any children or grandchildren ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (do you have any children or grandchildren ?) (0 :gist)
	  1 (0 do 4 children 0)
        2 (do you have any children or grandchildren ?) (0 :gist)
      ))

(READRULES '*reaction-to-children-input*
   '(1 (0 NEG 0)
       2 (Neither do you \.) (100 :out)
     1 (0)
       2 (0 child 0)
         3 (It must\'ve been nice raising children\.) (100 :out)
       2 (0 grandchild 0)
         3 (It must be wonderful having grandchildren\.) (100 :out)
	))
); end of eval-when
