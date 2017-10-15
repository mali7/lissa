(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  ))
   
;;  (How did you get here ?)
;;	(how-you-got-here)
;; 	from-how-you-got-here-input
;;  (0 to get here I 0)
;;  	gist-question: (1 How 2 get here 1)


 (READRULES '*specific-answer-from-how-you-got-here-input*
  '(
  1 (0 I 1 drove 0)
     2 ((To get here I drove a car \.)  (how-you-got-here)) (0 :gist)
  1 (0 I 1 drive 0)
     2 ((To get here I drove a car \.)  (how-you-got-here)) (0 :gist)
  1 (0 I have 2 vehicle 0)
     2 ((To get here I drove a car \.)  (how-you-got-here)) (0 :gist)
  1 (0 I took the bus 0)
     2 ((To get here I took the bus \.)  (how-you-got-here)) (0 :gist)
  1 (0 I 1 the bus 0)
     2 ((To get here I took the bus \.)  (how-you-got-here)) (0 :gist)
  1 (1 drove me 0)
     2 ((To get here someone drove me \.)  (how-you-got-here)) (0 :gist)
  1 (0 I went with 2)
     2 ((To get here someone drove me \.)  (how-you-got-here)) (0 :gist)
  1 (0 I was driven 0)
     2 ((To get here someone drove me \.)  (how-you-got-here)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-how-you-got-here-input*
    '())

 (READRULES '*unbidden-answer-from-how-you-got-here-input*
    '())
		
 (READRULES '*question-from-how-you-got-here-input*
    '(
    1 (0 what 2 you 0)
       2 (How did you get here ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (How did you get here ?) (0 :gist)
	  1 (0 did you drive 0)
       2 (How did you get here ?) (0 :gist)
    1 (0 do you drive 0)
       2 (How did you get here ?) (0 :gist)
    ))

(READRULES '*reaction-to-how-you-got-here-input*
  '( 
  1 (0 I drove 0)
     2 (That\'s good that I drove \. It must be nice to have the freedom to go somewhere when I want to \.) (100 :out)
  1 (0 I took the bus 0)
     2 (That\'s nice \. Buses can be a very efficient way to get around \.) (100 :out)
  1 (0 someone drove me 0)
     2 (It must be nice to go for a drive with someone I know \.) (100 :out)
  1 (0)
     2 (Well\, you\'re glad I could make it here today \.) (100 :out)
	))
); end of eval-when
