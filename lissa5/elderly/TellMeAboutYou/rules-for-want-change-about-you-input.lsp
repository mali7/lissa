(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (change-type weight strength healthy health)
    (change-from-type isolate introvert introvertive procrastinate procrastination)
    (change-to-type alone positive humor outgoing listener 
      independent listenning confidence)
    (change-to-two-type learn learning experiences experience skill skills)
   ))

;;	what are things you want to change about yourself ?
;;	(want-change-about-you)
;; 	from-want-change-about-you-input
;;	(0 thing 3 change about myself is 0) 
;;		gist-question: (1 what 2 things 3 change about yourself 1) 
   
(READRULES '*specific-answer-from-want-change-about-you-input*
   '(
    1 (0 change-type 0)
      2 ((I would like to change my 2) (want-change-about-you)) (0 :gist)
    1 (0 change-from-type 0) 
      2 ((The thing should change about myself is 2) (want-change-about-you)) (0 :gist)
    1 (0 NEG 2 change-to-type 0)
      2 ((I am 2 4 enough \.) (want-change-about-you)) (0 :gist)
    1 (0 change-to-type 0)
      2 ((I want to do things 2 \.) (want-change-about-you)) (0 :gist)
    1 (0 change-to-two-type change-to-two-type 0)
      2 ((I would like to 2 3 \.) (want-change-about-you)) (0 :gist)
    ;; no such area
    1 (0 not think 0)
      2 ((I can \' t think anything \.) (want-change-about-you)) (0 :gist)
    1 (0 NEG 0)
      2 ((not really \.) (want-change-about-you)) (0 :gist)
     ))
       
       
 (READRULES '*thematic-answer-from-want-change-about-you-input*
    '())

 (READRULES '*unbidden-answer-from-want-change-about-you-input*
    '())
		
 (READRULES '*question-from-want-change-about-you-input*
    '(1 (0 what 2 you 0)
        2 (what are things you want to change about yourself) (0 :gist)
      1 (0 how 2 you 0)
        2 (what are things you want to change about yourself) (0 :gist)
      ))

(READRULES '*reaction-to-want-change-about-you-input*
   '( 
    1 (0 change-type 0)
      2 (That \' s not easy .\ I hope you can do it \.) (100 :out)
    1 (0 change-from-type 0)
      2 (The things you want to change is 2 \. That makes sense \.) (100 :out)
    1 (0 change-to-type 0)
      2 (That sounds challenging \. I hope you be 2 \.) (100 :out)
    1 (0 change-to-two-type 1 change-to-two-type 0)
      2 (You want to 2 3 4 \. I believe you can make it \.) (100 :out)
    1 (0 not think 0)
      2 (Sounds you are satisfied with your current situation \. ) (100 :out)
    1 (0 NEG 0)
      2 (I understand \.) (100 :out)
    1 (0)
      2 (Sounds interesting \.) (100 :out)
	))
); end of eval-when
