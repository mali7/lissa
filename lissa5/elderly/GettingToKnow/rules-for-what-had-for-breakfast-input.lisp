(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (breakfast-one-word cereal juice milk bagel bagels fruit fruits yogurt coffee tea
    oatmeal toast bread almond almonds nut nuts clementine clemetines apple apples
    granola vegetable vegetables banana bananas grape grapes egg eggs omelette
    tofu muffin muffins waffle waffles pancake pancakes sausage sausages bacon
    berries blueberry blueberries strawberry strawberries vitamins)
  (breakfast-two-word fruit orange juice black coffee scrambled egg eggs bran
    toast apple cinnamon blueberry chocolate muffin muffins vitamin pills)
  ))
 
;; (what did you have for breakfast ?)
;; (breakfast-today)
;; from-what-had-for-breakfast-input
;; (0 I had 4 for breakfast 0) 
;;     gist-question: (2 what 1 you have 2 breakfast 1)


 (READRULES '*specific-answer-from-what-had-for-breakfast-input*
  '(
  1 (0 breakfast-two-word breakfast-two-word 0)
     2 ((I had 2 3 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-one-word 0)
     2 ((I had 2 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 skipped breakfast 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 didn\'t 1 breakfast 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-what-had-for-breakfast-input*
    '())

 (READRULES '*unbidden-answer-from-what-had-for-breakfast-input*
    '())
		
 (READRULES '*question-from-what-had-for-breakfast-input*
    '(
    1 (0 what 2 you 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 do you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 can you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    ))

(READRULES '*reaction-to-what-had-for-breakfast-input*
  '(
  1 (0 breakfast-two-word breakfast-two-word for breakfast 0)
     2 (You don\'t eat 2 3 often\, but it sounds like a good start to my day \.) (100 :out)
  1 (0 breakfast-one-word for breakfast 0)
     2 (You don\'t eat 2 often\, but it sounds like a good start to my day \.) (100 :out)
  1 (0 nothing for breakfast 0)
     2 (I must be hungry \. I should try to eat at least something small for breakfast \.) (100 :out)
  1 (0)
     2 (That sounds nice \. Thank me for telling you \.) (100 :out)
  ))
); end of eval-when
