(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (wishes-type healthy life health travel happy win wins active 
      productive engaged moving move retiring retire relationship 
      create relax)
    (wishes-two-type spend spending time make making money)
    (wishes-object life children child daughter son boy girl parents father mother friends)
   ))
;;	What are your hopes and wishes ?
;; 	(hopes-and-wishes)
;; 	from-hopes-and-wishes-input 
;;	(0 my hope is 0) (0 my wish is 0)
;;	gist-question: (1 what 2 hopes and wishes 1)

(READRULES '*specific-answer-from-hopes-and-wishes-input*
   '(   
    1 (0 wishes-two-type wishes-two-type 2 wishes-object 0)
      2 ((I would like to 2 3 with 5 \.) (hopes-and-wishes)) (0 :gist)
    1 (0 wishes-two-type wishes-two-type 0)
      2 ((I would like to 2 3 \.) (hopes-and-wishes)) (0 :gist)
    1 (0 wishes-type 2 wishes-object 0)
      2 ((One of my hopes is 2 4 \.) (hopes-and-wishes)) (0 :gist)
    1 (0 wishes-type 0)
      2 ((I would like to 2 \.) (hopes-and-wishes)) (0 :gist)

     ))
       
       
 (READRULES '*thematic-answer-from-hopes-and-wishes-input*
    '())

 (READRULES '*unbidden-answer-from-hopes-and-wishes-input*
    '())
		
 (READRULES '*question-from-hopes-and-wishes-input*
    '(1 (0 what 2 you 0)
        2 (what is your hopes and wishes for the future) (0 :gist)
      1 (0 how 2 you 0)
        2 (what is your hopes and wishes for the future) (0 :gist)
      1 (0 your hopes 0)
        2 (what is your hopes and wishes for the future) (0 :gist)
      1 (0 your whishes 0)
        2 (what is your hopes and wishes for the future) (0 :gist)
      ))

(READRULES '*reaction-to-hopes-and-wishes-input*
   '( 
    1 (0 wishes-two-type wishes-two-type 2 wishes-object 0)
      2 (You wish to 2 3 4\. That makes sense \.) (100 :gist)
    1 (0 wishes-two-type wishes-two-type 0)
      2 (You hope to 2 3 \. It is a big step for you \.) (100 :gist)
    1 (0 wishes-type 2 wishes-object 0)
      2 (You wish 2 3 4 in the future \.)
    1 (0 wishes-type 0)
      2 (That makes sense \. It will be great your wishes come true \. ) (100 :gist)
    1 (0)
      2 (I hope your dream come ture \.) (100 :gist)
	))
); end of eval-when
