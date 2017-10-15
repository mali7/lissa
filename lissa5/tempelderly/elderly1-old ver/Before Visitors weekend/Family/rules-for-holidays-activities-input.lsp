(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((siblings brother sister brothers sisters)
     (travel travels trip trips)
	 (first-per-poss-pron my our)))
;; (What do you usually do for holidays ?)
;;	(holidays-activities)
;;		from-holidays-activities-input
;;			(0 On holidays 0)
;;			gist-question:(3 what 2 you 3 holidays 0)

 (READRULES '*specific-answer-from-holidays-activities-input*
   '(1 (0 get together 0) 
        2 ((On holidays we get together \.)  (holidays-activities)) (0 :gist) 		
     1 (0 we 2 gather 0) 
        2 ((On holidays we all gather together \.)  (holidays-activities)) (0 :gist) 		
     1 (0 my siblings 0) 
        2 ((On holidays we get together with my siblings \.)  (holidays-activities)) (0 :gist) 		
     1 (0 travel 0) 
        2 ((On holidays I travel \.)  (holidays-activities)) (0 :gist) 		
     1 (0 my 2 family 0) 
        2 ((On holidays we get together with my family \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-pron 3 invite 2 family 0) 
        2 ((On holidays I invite family members \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-pron 3 invite 2 friends 0) 
        2 ((On holidays I invite friends \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-poss-pron home 0) 
        2 ((On holidays we gather in my home \.)  (holidays-activities)) (0 :gist) 		
     1 (0 join 2 family 0) 
        2 ((On holidays we get together with my family \.)  (holidays-activities)) (0 :gist) 		
     ))
       
       
 (READRULES '*thematic-answer-from-holidays-activities-input*
    '())

 (READRULES '*unbidden-answer-from-holidays-activities-input*
    '())
		
 (READRULES '*question-from-holidays-activities-input*
    '(1 (0 what 2 you 0)
        2 (what do you do for holidays ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (what do you do for holidays ?) (0 :gist)
	  1 (0 what do 4 holidays 0)
        2 (what do you do for holidays ?) (0 :gist)
      1 (0 what do 4 thanksgiving 0)
        2 (what do you do for holidays ?) (0 :gist)
      ))

(READRULES '*reaction-to-holidays-activities-input*
   '(1 (0 together 0)
  2 (0 siblings 0)
    3 (That sounds fun\. It\'s always good to reuinite with my siblings\.) (100 :out)
  2 (It\'s always nice to get together with the people I love\.) (100 :out)
1 (0 gather in my home 0)
  2 (It must be fun to have everyone over at my house\.) (100 :out)
1 (0 travel 0)
  2 (Traveling for the holidays sounds like a nice thing to look forward to\.) (100 :out)
1 (0 invite friends 0)
  2 (It must be fun to have friends over\.) (100 :out)
1 (0 invite family 0)
  2 (It must be fun to have family over\.) (100 :out)

  ))
); end of eval-when
