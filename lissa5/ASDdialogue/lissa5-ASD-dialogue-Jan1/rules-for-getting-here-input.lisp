; getting-here


(eval-when (load eval)
  (mapc 'attachfeat '(
    (yes yeah)
    (easy fine OK good alright hard)
  ))


  (readrules '*specific-answer-from-getting-here-input*
    '(1 (0 yes 0)
      2 ((It was easy to get here \.) (getting-here)) (0 :gist)
    1 (0 no 0)
      2 ((It was hard to get here \.) (getting-here)) (0 :gist)
    1 (3 NEG easy 0)
      2 ((It was hard to get here \.) (getting-here)) (0 :gist)
    1 (3 NEG hard 0)
      2 ((It was easy to get here \.) (getting-here)) (0 :gist)
    1 (3 easy 0)
      2 ((It was easy to get here \.) (getting-here)) (0 :gist)
    1 (3 hard 0)
      2 ((It was hard to get here \.) (getting-here)) (0 :gist)
    ))


  (readrules '*thematic-answer-from-getting-here-input*
    '())


  (readrules '*unbidden-answer-from-getting-here-input*
    '())


  (readrules '*question-from-getting-here-input*
    '())


  (readrules '*reaction-to-getting-here-input*
    '())


)
