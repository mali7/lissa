(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (quaility-types listening postive encourager modest humor dramatize 
      smile help helping heigth conversation relationship kind intelligent 
      comfortable help helping friendly easygoing)
    (quaility-two-types get along work hard worker)
    (blur-types try maybe probabily)
   ))
  }

;;	What are your best qualities ?
;;	(your-best-quality)
;; 	from-your-best-quality-input
;;	(0 My best quality is 0)
;;		gist-question: (2 what 1 your best qualities 1)


 (READRULES '*specific-answer-from-your-best-quality-input*
   '(
    1 (0 quaility-types 0)
      2 ((One of my best qualities is 2 \.) (your-best-quality)) (0 :gist)
    1 (0 quaility-two-types quaility-two-types 0)
      2 ((One of my best qualities is 2 3 \.) (your-best-quality)) (0 :gist)
    ;; if there is no clear answer
    1 (0 not think 3 too much)
      2 ((I do not think about it too much \.) (your-best-quality)) (0 :gist)
     ))
       
       
 (READRULES '*thematic-answer-from-your-best-quality-input*
    '())

 (READRULES '*unbidden-answer-from-your-best-quality-input*
    '())
		
 (READRULES '*question-from-your-best-quality-input*
    '(1 (0 what 2 you 0)
        2 (what do you think are your best qualities) (0 :gist)
      1 (0 how 2 you 0)
        2 (what do you think are your best qualities) (0 :gist)
      1 (0 your best qualities 0)
        2 (what do you think are your best qualities) (0 :gist)
      ))

(READRULES '*reaction-to-your-best-quality-input*
   '( 
    1 (0 quaility-types 0)
      2 (It is great to be 2 \. I would like to make friends with such kind of person \.) (100 :out)
    1 (0 quaility-two-types quaility-two-types 0)
      2 (Cool, 2 3 is a good quality \.) (100 :out)
    1 (0 NEG 0)
      2 (Tell me more \.) (100 :out)
    1 (0 blur-types 0)
      2 (Can you give me an example ?) (100 :out)
    1 (0)
      2 (That's sweet \.) (100 :out)
	))
); end of eval-when
