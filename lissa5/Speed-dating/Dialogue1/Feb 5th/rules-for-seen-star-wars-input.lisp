(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '((yes yeah) (no nope nah)))

 (READRULES '*specific-answer-from-seen-star-wars-input*
  '(1 (0 I saw 0)
     2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
    1 (0 yes 0)
	 2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 I have 0)
	 2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 no 0)
	 2 ((I have not seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)
	1 (0 NEG 0)
	 2 ((I have not seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)))
 
 ; No thematic answers expected
 (READRULES '*thematic-answer-from-seen-star-wars-input*
  '())

 ; No unbidden answers expected (at least, not unless we have a subdialogue for this topic)
 (READRULES '*unbidden-answer-from-seen-star-wars-input*
  '())

  ; Reciprocal question
 (READRULES '*question-from-seen-star-wars-input* 
  '())
 
 ; Temporary. Again, we might/should have a subdialogue for this question
 (READRULES '*reaction-to-seen-star-wars-input*  
  '(1 (I have seen the new Star Wars film \.)
     2 (That\'s interesting\, since it hasn\'t come out yet\.) (100 :out)
	1 (I have not seen the new Star Wars film\.)
	 2 (Of course\. It hasn\'t come out yet\, after all\.) (100 :out)))

); end of eval-when