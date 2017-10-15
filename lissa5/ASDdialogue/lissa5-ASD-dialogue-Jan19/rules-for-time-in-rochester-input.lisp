; time-in-rochester


(eval-when (load eval)
  (mapc 'attachfeat '(
    (many five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty)
    (month months)
  ))


  (readrules '*specific-answer-from-time-in-rochester-input*
    '(1 (0 life 0)
      2 ((I\'ve been in Rochester my whole life \.) (time-in-rochester)) (0 :gist)
    1 (0 many years 0)
      2 ((I\'ve been in Rochester for many years \.) (time-in-rochester)) (0 :gist)
    1 (0 years 0)
      2 ((I\'ve been in Rochester for several years \.) (time-in-rochester)) (0 :gist)
    1 (0 year 0)
      2 ((I\'ve been in Rochester for almost a year \.) (time-in-rochester)) (0 :gist)
    1 (0 month 0)
      2 ((I\'ve been in Rochester for a few months \.) (time-in-rochester)) (0 :gist)
    ))


  (readrules '*thematic-answer-from-time-in-rochester-input*
    '())


  (readrules '*unbidden-answer-from-time-in-rochester-input*
    '())


  (readrules '*question-from-time-in-rochester-input*
    '(1 (0 how 0 you 0)
      2 (How long have you been here in Rochester ?) (0 :gist)
    1 (0 what 0 you 0)
      2 (How long have you been here in Rochester ?) (0 :gist)
    1 (0 how long 2 been 0 in Rochester 0)
      2 (How long have you been here in Rochester ?) (0 :gist)
    ))


  (readrules '*reaction-to-time-in-rochester-input*
    '(1 (0 whole life 0)
      2 (Wow\, that is longer than you have been anywhere\!) (100 :out)
    1 (0 many years 0)
      2 (Wow\, that is longer than you have been anywhere\!) (100 :out)
    1 (0 several years 0)
      2 (So I have been here for a while\.) (100 :out)
    1 (0 a year 0)
      2 (I am pretty new here\.) (100 :out)
    1 (0 months 0)
      2 (I am pretty new here\.) (100 :out)
    ))


)
