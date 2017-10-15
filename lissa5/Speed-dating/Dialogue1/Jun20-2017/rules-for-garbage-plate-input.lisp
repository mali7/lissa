(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '((gp-ingredients sauce macaroni potato cheese mustard ketchup burger hamburger fries)
    (greasy greasiest)))

; Since the question is open-ended, we're not really looking for specific answer.
; Gist clauses will be derived from the thematic answer rules.

(READRULES '*specific-answer-from-garbage-plate-input*
   '(1 (0 NEG idea 0)
        2 ((I do not know about garbage plate \.) (garbage-plate)) (0 :gist)
     1 (0 have NEG tried 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 I\'ve NEG tried 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 I\'ve never tried 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 have never tried 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 have 3 NEG 3 had 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 I\'ve 3 never 3 had 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 have 3 never 3 had 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 NEG tested 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 have never tested 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 I\'ve never tested 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 have 3 NEG 3 been 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
	 1 (0 gp-ingredients 0)
        2 ((I told you garbage plate ingredients \.) (garbage-plate)) (0 :gist)
	 1 (0 greasy 0)
	    2 ((Garbage plate is a greasy food \.) (garbage-plate)) (0 :gist)
	 1 (0 NEG know 0)
        2 ((I do not know about garbage plate \.) (garbage-plate)) (0 :gist)
     1 (0 don\'t know 0)
        2 ((I do not know about garbage plate \.) (garbage-plate)) (0 :gist)
     1 (0 NEG like 0)
        2 ((I do not like garbage plate \.) (garbage-plate)) (0 :gist)	
     1 (0 3 0)
        2 ((Nothing found about garbage plate \.) (garbage-plate)) (0 :gist)
		))
		
 (READRULES '*thematic-answer-from-garbage-plate-input*
    '(1 (0 BADPRED 0)
    	  2 ((I do not like garbage plates \.) (garbage-plate)) (0 :gist)
      1 (0 NEG GOODPRED 0)
        2 ((I do not like garbage plates \.) (garbage-plate)) (0 :gist)
      1 (0 NEG 1 GOODPRED 0)
        2 ((I do not like garbage plates \.) (garbage-plate)) (0 :gist)
      1 (0 GOODPRED 0)
        2 ((I like garbage plates \.) (garbage-plate)) (0 :gist)
      1 ((I have no sentiment about garbage plates\.) (garbage-plate)) (0 :gist)))

; Not expecting anything here
 (READRULES '*unbidden-answer-from-garbage-plate-input*
    '())

; Lissa's prompt implies that she knows nothing about garbage plates, so we're
; not expecting a reciprocal question. We might get a question such as:
; "It's a pile of home fries and protein and sauce. Do you like that kind of thing?"
; but questions like that could be adequately covered by "I'll have to try it sometime."
; We could consider including the "How do you even eat?" question here. Unless we're
; covering those questions in a rule set separate from the main track.
 (READRULES '*question-from-garbage-plate-input*
    '(1 (0 have you 2 tried it 0)
	    2 ((Have you tried garbage plate yet ?) (garbage-plate)) (0 :gist)
	  1 (0 have you 2 tried 2 garbage plate 0)
	    2 ((Have you tried garbage plate yet ?) (garbage-plate)) (0 :gist)
	))

 (READRULES '*reaction-to-garbage-plate-input*
   '(1 (0 I do not know 0)
       2 (Well\, I should try it at least once\. You will definitely check it out some time \. ) (100 :out)
     1 (0 I have not tried 0)
       2 (Well\, I should try it at least once\. You will definitely check it out some time \. ) (100 :out)
     1 (0 I told you 0 ingredients 0)
       2 (Wow\, that sounds like a funny idea \. You will definitely try it some time \.) (100 :out)
     1 (0 greasy 0)
       2 (Sounds like it\'s high-calorie but good \.) (100 :out)
     1 (0 NEG like 0)
       2 (You do not know if you like it but I\'m actually curious to try it \.) (100 :out)
     1 (0 I like 0) 
	   2 (You guess you will like it too \. You should give it a try \.) (100 :out)
	 1 (0 Nothing found 0) 
	   2 (You guess you will like it \. You should give it a try \.) (100 :out)
   )); end of *reaction-to-garbage-plate-input*

); end of eval-when
