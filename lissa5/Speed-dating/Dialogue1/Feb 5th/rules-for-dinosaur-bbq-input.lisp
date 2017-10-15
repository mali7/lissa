(eval-when (load eval) 
  (MAPC 'ATTACHFEAT
  '((yes yeah)))

; phrases for gist extraction:
 (READRULES '*specific-answer-from-dinosaur-input*
   '(1 (NEG 0)
    2 ((I have not been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (1 NEG 0)
    2 ((I have not been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (2 NEG 0)
    2 ((I have not been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (3 NEG 0)
    2 ((I have not been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (4 NEG 0)
    2 ((I have not been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (5 NEG 0)
    2 ((I have not been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (yes 0)
    2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (1 yes 0)
    2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (2 yes 0)
    2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (3 yes 0)
    2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
   1 (4 yes 0)
    2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)))

 (READRULES '*thematic-answer-from-dinosaur-bbq-input*
    '())
 (READRULES '*unbidden-answer-from-dinosaur-bbq-input*
    '())

 (READRULES '*question-from-dinosaur-bbq-input*
    '(1 (0 have you 0)
        2 (Have you been to Dinosaur BBQ ?) (0 :gist)
      1 (0 wh_ 1 you 0)
        2 (Have you been to Dinosaur BBQ ?) (0 :gist)))
 (READRULES '*reaction-to-dinosaur-bbq-input*
   '(1 (0 have been 0)
       2 (Yeah\, you like it there\.) (100 :out)
     1 (0 have not been 0)
       2 (I should try it\. I\'ve heard it\'s a nice place\.) (100 :out)
     1 (You don\'t quite understand\, but okay\.) (100 :out)
     )); end of *reaction-to-dinosaur-input*

); end of eval-when