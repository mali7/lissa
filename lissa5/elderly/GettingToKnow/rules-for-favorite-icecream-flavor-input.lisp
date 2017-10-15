(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   (icecream-types gelato sherbet sorbet custard)
   (icecream-flavors vanilla chocolate chip swirl mint peppermint fudge
   cookie dough raspberry strawberry coffee scotch cherry maple walnut
   pecan pistachio tea banana mango coconut rocky road chunky monkey
   grape melon orange lemon blue moon rainbow cotton candy)

   ;Two-word: cookie dough, maple walnut, french vanilla, chocolate chip,
   ;chunky monkey, rocky road, blue moon, cotton candy

   ;Three-word: mint chocolate chip, cookies and cream

   ))
   
;;  (what is your favorite flavor of ice cream ?)
;;	(favorite-icecream)
;; 	from-favorite-icecream-flavor-input
;;  (0 ice cream flavor I like 0)
;;  	gist-question: (1 what 2 favorite 2 icecream 1) 


 (READRULES '*specific-answer-from-favorite-icecream-flavor-input*
  '(
  1 (0 icecream-flavors icecream-flavors icecream-flavors icecream-types 0)
     2 ((The ice cream flavor I like is 2 3 4 5 \.)  (favorite-icecream)) (0 :gist)
  1 (0 cookies and cream icecream-types 0) ;; cookies and cream is the only specific ice cream flavor I know that's joined by an "and".
                                           ;; doing "icecream-flavors and icecream-flavors" would mistakenly match when people name two different flavors, e.g. "I like vanilla and strawberry"
     2 ((The ice cream flavor I like is cookies and cream 5 \.)  (favorite-icecream)) (0 :gist)
  1 (0 icecream-flavors icecream-flavors icecream-types 0)
     2 ((The ice cream flavor I like is 2 3 4 \.)  (favorite-icecream)) (0 :gist)
  1 (0 icecream-flavors icecream-types 0)
     2 ((The ice cream flavor I like is 2 3 \.)  (favorite-icecream)) (0 :gist)
  1 (0 icecream-flavors icecream-flavors icecream-flavors 0)
     2 ((The ice cream flavor I like is 2 3 4 \.)  (favorite-icecream)) (0 :gist)
  1 (0 cookies and cream 0) ;; See above
     2 ((The ice cream flavor I like is cookies and cream \.)  (favorite-icecream)) (0 :gist)
  1 (0 icecream-flavors icecream-flavors 0)
     2 ((The ice cream flavor I like is 2 3 \.)  (favorite-icecream)) (0 :gist)
  1 (0 icecream-flavors 0)
     2 ((The ice cream flavor I like is 2 \.)  (favorite-icecream)) (0 :gist)

  ;; >>>>>> These four gist clauses aren't matched currently. <<<<<<<<
  1 (0 do not 2 ice cream 0)
     2 ((I do not have a favorite ice cream flavor \.)  (favorite-icecream)) (0 :gist)
  1 (0 don\'t 2 ice cream 0)
     2 ((I do not have a favorite ice cream flavor \.)  (favorite-icecream)) (0 :gist)
  1 (0 do not 2 favorite 0)
     2 ((I do not have a favorite ice cream flavor \.)  (favorite-icecream)) (0 :gist)
  1 (0 don\'t 2 favorite 0)
     2 ((I do not have a favorite ice cream flavor \.)  (favorite-icecream)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-favorite-icecream-flavor-input*
    '())

 (READRULES '*unbidden-answer-from-favorite-icecream-flavor-input*
    '(
    1 (0 favorite food 0)
       2 ((The food I like is ice cream \.)  (favorite-icecream)) (0 :gist)
    ))
		
 (READRULES '*question-from-favorite-icecream-flavor-input*
    '(
    1 (0 what 2 you 0)
       2 (What is your favorite flavor of ice cream ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What is your favorite flavor of ice cream ?) (0 :gist)
	  1 (0 your favorite 0)
       2 (What is your favorite flavor of ice cream ?) (0 :gist)
    1 (0 do you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 can you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    ))

(READRULES '*reaction-to-favorite-icecream-flavor-input*
  '( 
  1 (0 icecream-flavors icecream-flavors icecream-flavors icecream-types 0)
     2 (You like 5\. You will have to try 2 3 4 sometime \.) (100 :out)
  1 (0 cookies and cream icecream-types 0) ;; See above
     2 (You like 5\. You will have to try cookies and cream sometime \.) (100 :out)
  1 (0 icecream-flavors icecream-flavors icecream-types 0)
     2 (You like 4\. You will have to try 2 3 sometime \.) (100 :out)
  1 (0 icecream-flavors icecream-types 0)
     2 (You like 3\. You will have to try 2 sometime \.) (100 :out)
  1 (0 icecream-flavors icecream-flavors icecream-flavors 0)
     2 (You think 2 3 4 is pretty tasty \.) (100 :out)
  1 (0 cookies and cream 0) ;; See above
     2 (You think cookies and cream is pretty tasty \.) (100 :out)
  1 (0 icecream-flavors icecream-flavors 0)
     2 (You think 2 3 is pretty tasty \.) (100 :out)
  1 (0 icecream-flavors 0)
     2 (You think 2 is pretty tasty \.) (100 :out)
  1 (0 NEG 2 favorite 0)
     2 (You can\'t eat ice cream\, so you don\'t have a favorite flavor \.) (100 :out)
  1 (0)
     2 (There are so many good desserts to try \.) (100 :out)
	))
); end of eval-when
