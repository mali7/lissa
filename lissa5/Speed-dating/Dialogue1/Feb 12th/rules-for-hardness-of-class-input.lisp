; This is a small trial pattern base for reacting to the user's
; answer concerning what s/he likes about Rochester.

; We also provide features, supplementing the generic ones in
; "general-word-data.lisp", relevant to the topic here.

(eval-when (load eval)
 
 (MAPC 'ATTACHFEAT
  '((yes yeah)
          (easy manageable fine)))
		  
 
(READRULES '*specific-answer-from-hardness-of-class-input*
  '(1 (0 NEG 0 hard 0)
    2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 NEG 0 easy 0)
    2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 no problem 0)
    2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 a little bit 0)
    2 ((I did find my favorite class a little hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 yes 0)
    2 ((I did find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 hard 0)
    2 ((I did find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 easy 0)
    2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 no 0)
    2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
  1 (0 3 0)
    2 ((Nothing found about whether the favorite class was hard \.) (favorite-class difficulty)) (0 :gist)
	
))
 
(READRULES '*thematic-answer-from-hardness-of-class-input*
    '())

 (READRULES '*unbidden-answer-from-hardness-of-class-input*
	())

 (READRULES '*question-from-hardness-of-class-input*
    '(1 (what 0 you 0)
		2 (Did you find your favorite class hard ?) (0 :gist)
      1 (how 0 you 0)
        2 (Did you find your favorite class hard ?) (0 :gist)
	  1 (0 you find 3 hard 0)
	    2 (Did you find your favorite class hard ?) (0 :gist)
     ))
  ;  1 (did you find 0 hard ? 0)
   ;    2 (you thought your favorite class was hard but rewarding \.) (100 :out)
    
 (READRULES '*reaction-to-hardness-of-class-input* 
   '(1 (I did not find 0 hard 0)
       2 (It\'s good I enjoy what comes naturally to me \.) (100 :out)
    1 (I did find 0 a little bit hard 0)
       2 (I must have learned a lot from it\.) (100 :out)
    1 (I did find 0 hard 0)
      2 (I must have learned a lot from it\.) (100 :out)
    1 (0 nothing found 0)
	   2 (You are sure I have learned a lot from it \.) (100 :out)
    ))

); end of eval-when