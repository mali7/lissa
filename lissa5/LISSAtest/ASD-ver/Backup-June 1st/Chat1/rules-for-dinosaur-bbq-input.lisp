(eval-when (load eval) 
  (MAPC 'ATTACHFEAT
  '((yes yeah)))

; phrases for gist extraction:
 (READRULES '*specific-answer-from-dinosaur-bbq-input*
   '(1 (NEG 0)
    2 ((I have not been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (1 NEG 0)
    2 ((I have not been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (2 NEG 0)
    2 ((I have not been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (3 NEG 0)
    2 ((I have not been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (4 NEG 0)
    2 ((I have not been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (5 NEG 0)
    2 ((I have not been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (0 I GOODATTITUDE Dinosaur 0)
    2 ((I love Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (0 I GOODATTITUDE 2 Barbecue 0)
    2 ((I love Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (yes 0)
    2 ((I have been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (1 yes 0)
    2 ((I have been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (2 yes 0)
    2 ((I have been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (3 yes 0)
    2 ((I have been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (4 yes 0)
    2 ((I have been to Dinosaur Barbecue \.) (dinosaur)) (0 :gist)
   1 (0 3 0)
    2 ((Nothing found about Dinosaur Barbecue \.) (dinosaur)) (0 :gist)))

 (READRULES '*thematic-answer-from-dinosaur-bbq-input*
    '())
 (READRULES '*unbidden-answer-from-dinosaur-bbq-input*
    '())

 (READRULES '*question-from-dinosaur-bbq-input*
    '(1 (0 have you 0)
        2 (Have you been to Dinosaur barbecue ?) (0 :gist)
      1 (0 wh_ 1 you 0)
        2 (Have you been to Dinosaur barbecue ?) (0 :gist)))
 
 (READRULES '*reaction-to-dinosaur-bbq-input*
   '(1 (0 love Dinosaur barbecue 0)
       2 (So I am a fan of the place \. You definitely should try it soon \.) (100 :out)
     1 (0 have been 0)
       2 (You have not been there but you plan to try it soon\, since you are a fan of barbecue \.) (100 :out)
     1 (0 have not been 0)
       2 (I should try it\. You have heard it\'s a nice place\.) (100 :out)
     1 (0 nothing found 0) 
	  2 (You have heard so many nice comments about the place\.  ) (100 :out)
     )); end of *reaction-to-dinosaur-input*

); end of eval-when
