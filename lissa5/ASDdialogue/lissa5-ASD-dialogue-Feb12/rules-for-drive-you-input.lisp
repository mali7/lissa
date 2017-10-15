; drive-you


(eval-when (load eval)
  (mapc 'attachfeat '(
    (yes yeah)
    (no nope)
  ))


  (readrules '*specific-answer-from-drive-you-input*
    '(1 (0 yes 0)
      2 ((Somebody drove me \.) (drive-you)) (0 :gist)
    1 (3 family 0)
     2 ((My 2 drove me \.) (drive-you)) (0 :gist)
    1 (3 NEG 0)
      2 ((Somebody did not drive me \.) (drive-you)) (0 :gist)
    1 (0 no 0)
      2 ((Somebody did not drive me \.) (drive-you)) (0 :gist)
    ))


  (readrules '*thematic-answer-from-drive-you-input*
    '())


  (readrules '*unbidden-answer-from-drive-you-input*
    '())


  (readrules '*question-from-drive-you-input*
    '())


  (readrules '*reaction-to-drive-you-input*
    '(1 (0)
        2 (That\'s nice \.) (100 :out)))


)
