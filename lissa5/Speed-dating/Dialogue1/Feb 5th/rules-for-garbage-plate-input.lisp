(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '((gp-ingredients macaroni potato cheese mustard ketchup burger fries)))

; Since the question is open-ended, we're not really looking for specific answer.
; Gist clauses will be derived from the thematic answer rules.

(READRULES '*specific-answer-from-garbage-plate-input*
   '(1 (0 NEG idea 0)
        2 ((I do not know about garbage plate\.) (garbage-plate)) (0 :gist)
     1 (0 NEG know 0)
        2 ((I do not know about garbage plate\.) (garbage-plate)) (0 :gist)
     1 (0 NEG tried 0)
        2 ((I have not tried garbage plate \.) (garbage-plate)) (0 :gist)
     1 (0 gp-ingredients 0)
        2 ((I told you garbage plate ingredients \.) (garbage-plate)) (0 :gist)))
 (READRULES '*thematic-answer-from-garbage-plate-input*
    '(1 (0 BADPRED 0)
    	  2 ((I do not like garbage plates\.) (garbage-plate)) (0 :gist)
      1 (0 NEG GOODPRED 0)
        2 ((I do not like garbage plates\.) (garbage-plate)) (0 :gist)
      1 (0 NEG 1 GOODPRED 0)
        2 ((I do not like garbage plates\.) (garbage-plate)) (0 :gist)
      1 (0 GOODPRED 0)
        2 ((I like garbage plates\.) (garbage-plate)) (0 :gist)
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
    '())

 (READRULES '*reaction-to-garbage-plate-input*
   '(1 (I do not know 0)
       2 (Well\, I should try it at least once\. You will definitely check it out sometime \. ) (100 :out)
     1 (I do not like 0)
       2 (That sounds like a funny idea\. You are not sure if you would like it\.) (100 :out)
     1 (I like 0)
       2 (Wow\, that\'s interesting\. You will have to try it sometime\.) (100 :out)
     1 (I 0 garbage plate ingredients 0)
       2 (Wow\, that\'s interesting\. You will have to try it sometime\.) (100 :out)
     1 (Well\, you will have to check it out sometime\.) (100 :out)
   )); end of *reaction-to-garbage-plate-input*

 ;(READRULES '*reaction-to-garbage-plate-input*
 ;  '(1 (I do not like 0)
  ;     2 (That sounds like a funny idea\. You are not sure if you would like it\.) (100 :out)
   ;  1 (I like 0)
    ;   2 (Wow\, that\'s interesting\. You will have to try it sometime\.) (100 :out)
     ;1 (Well\, you will have to check it out sometime\.) (100 :out)
   ;)); end of *reaction-to-garbage-plate-input*

); end of eval-when
