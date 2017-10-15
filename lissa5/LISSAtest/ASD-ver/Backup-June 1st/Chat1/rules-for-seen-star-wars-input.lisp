(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '((yes yeah) (no nope nah)))

 (READRULES '*specific-answer-from-seen-star-wars-input*
  '(1 (0 I saw 0)
     2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
    1 (0 haven\'t 0)
	 2 ((I have not seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 yes 0)
	 2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 no 0)
	 2 ((I have not seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 NEG 0)
	 2 ((I have not seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 I have 0)
	 2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 3 0)
	 2 ((Nothing found for seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	 ))
 
 ; No thematic answers expected
 (READRULES '*thematic-answer-from-seen-star-wars-input*
  '())

 ; No unbidden answers expected (at least, not unless we have a subdialogue for this topic)
 (READRULES '*unbidden-answer-from-seen-star-wars-input*
  '())

  ; Reciprocal question
 (READRULES '*question-from-seen-star-wars-input* 
  '(1 (0 what 1 you 0)
     2 (Have you seen the new Star Wars film ?) (0 :gist)
	1 (0 how 1 you 0)
	 2 (Have you seen the new Star Wars film ?) (0 :gist)
	1 (0 have you seen 0 Star Wars 0) 
	 2 (Have you seen the new Star Wars film ?) (0 :gist)
	1 (0 did you see 0 Star Wars 0) 
	 2 (Have you seen the new Star Wars film ?) (0 :gist)
	1 (0 have you 0) 
	 2 (Have you seen the new Star Wars film ?) (0 :gist)
	 ))
        
 ; Temporary. Again, we might/should have a subdialogue for this question
 (READRULES '*reaction-to-seen-star-wars-input*  
  '(1 (0 I have seen the new Star Wars film \.)
     2 (Cool \, it is still in theaters \, You definitely go to see it soon \.) (100 :out)
	1 (0 I have not seen the new Star Wars film \.)
	 2 (You have not had the chance to see it neither \, But the good news is that it is still up \.) (100 :out)
	1 (0 Nothing found 0)
	 2 (OK\.) (100 :out)
	 ))

); end of eval-when