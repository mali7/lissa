(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (american-holidays Christmas Halloween Thanksgiving Easter valentine)
      (fourth 4th) ))
;; (Are there other holidays you prefer ?)
;;	(holidays-you-prefer)
;;		from-holidays-you-prefer-input
;;			(0 The holiday I prefer is 0)
;;			gist-question:(3 are there 2 holidays you prefer 0)

 (READRULES '*specific-answer-from-holidays-you-prefer-input*
   '(1 (NEG 0) 
        2 ((The holiday I prefer is Thanksgiving \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 american-holidays 0) 
        2 ((The holiday I prefer is 2 \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 Independence day 0) 
        2 ((The holiday I prefer is 2 3 \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 New year\'s 1 0) 
        2 ((The holiday I prefer is New year\'s 1 \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 fourth 1 July 0) 
        2 ((The holiday I prefer is fourth of July \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 mother\'s day 0) 
        2 ((The holiday I prefer is mother\'s day \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 father\'s day 0) 
        2 ((The holiday I prefer is father\'s day \.)  (holidays-you-prefer)) (0 :gist) 		
     1 (0 valentine\'s day 0) 
        2 ((The holiday I prefer is valentine \.)  (holidays-you-prefer)) (0 :gist) 		
     ))
       
       
 (READRULES '*thematic-answer-from-holidays-you-prefer-input*
    '())

 (READRULES '*unbidden-answer-from-holidays-you-prefer-input*
    '())
		
 (READRULES '*question-from-holidays-you-prefer-input*
    '(1 (0 what 2 you 0)
        2 (are there other holidays you prefer ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (are there other holidays you prefer ?) (0 :gist)
	  1 (0 wh_ 2 holidays 2 do you 0)
        2 (are there other holidays you prefer ?) (0 :gist)
      1 (0 holidays you 0)
        2 (are there other holidays you prefer ?) (0 :gist)
      ))

(READRULES '*reaction-to-holidays-you-prefer-input*
   '(1 (0 Thanksgiving 0)
  2 (Well\, that\'s nice \.) (100 :out)
1 (0 american-holidays 0)
  2 (You think 2 is a fun holiday\, too\.) (100 :out)
1 (0 independence 0)
  2 (You always enjoy the fourth of july fireworks \.) (100 :out)
1 (0 new year\'s 0)
  2 (You like celebrating a new year\, a fresh start\.) (100 :out)
1 (0 fourth 0)
  2 (You always enjoy the fourth of july fireworks \.) (100 :out)
1 (0 mother\'s 0)
  2 (It\'s nice to have a day to think of the parents\.) (100 :out)
1 (0 father\'s 0)
  2 (It\'s nice to have a day to think of the parents\.) (100 :out)
1 (0 valentine 0)
  2 (That\'s very romantic\.) (100 :out)
1 (That\'s nice\.) (100 :out)
	))
); end of eval-when
