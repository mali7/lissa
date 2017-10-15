; free-time


(eval-when (load eval)
  (mapc 'attachfeat '(
    (like prefer)
    (books reading)
    (movies movie cinema film films)
    (streaming netflix hulu)
    (contrary actually neither none rather)
  ))


  (readrules '*specific-answer-from-free-time-input*
    '(1 (0 like books 0)
        2 ((I like reading \.) (free-time)) (0 :gist)
      1 (0 like reading 0)
        2 ((I like reading \.) (free-time)) (0 :gist)
      1 (0 like TV 0)
        2 ((I like watching TV \.) (free-time)) (0 :gist)
      1 (0 like movies 0)
        2 ((I like watching movies \.) (free-time)) (0 :gist)
      1 (0 like watching 0)
        2 (0 TV 0)
          3 ((I like watching TV \.) (free-time)) (0 :gist)
        2 (0 movies 0)
          3 ((I like watching movies \.) (free-time)) (0 :gist)
        2 (0 streaming 0)
          3 ((I like watching 2 \.) (free-time)) (0 :gist)
        2 ((I like watching TV or movies \.) (free-time)) (0 :gist)
      1 (0 I\'m 0 NEG 0 reader 0)
        2 ((I like watching TV or movies \.) (free-time)) (0 :gist)
      1 (0 I 0 NEG 0 read 0)
        2 ((I like watching TV or movies \.) (free-time)) (0 :gist)
      1 (0 I\'m 0 reader 0)
        2 ((I like reading \.) (free-time)) (0 :gist)
      1 (0 I read 0)
        2 ((I like reading \.) (free-time)) (0 :gist)
      1 (0 I watch 0)
        2 (0 TV 0)
          3 ((I like watching TV \.) (free-time)) (0 :gist)
        2 (0 movies 0)
          3 ((I like watching movies \.) (free-time)) (0 :gist)
        2 (0 streaming 0)
          3 ((I like watching 2 \.) (free-time)) (0 :gist)
        2 ((I like watching TV or movies \.) (free-time)) (0 :gist)
      1 (0 contrary 0 like spare-time-activity 0)
        2 ((I like 5 \.) (free-time)) (0 :gist)
      ))


  (readrules '*thematic-answer-from-free-time-input*
    '())


  (readrules '*unbidden-answer-from-free-time-input*
    '())


  (readrules '*question-from-free-time-input*
    '(1 (0 what 0 you 0)
        2 (Do you like watching TV or movies or reading books ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (Do you like watching TV or movies or reading books ?) (0 :gist)
      ))


  (readrules '*reaction-to-free-time-input*
    '(1 (0 TV 0)
        2 (You like watching TV a lot \.) (100 :out)
      1 (0 movies 0)
        2 (You like movies a lot \.) (100 :out)
      1 (0 books 0)
        2 (You think books are a great way to spend time \, though you sometimes find it hard to concentrate on them \, since I\'m so animated \.) (100 :out)
      1 (I like 0 \.)
        2 (3 sounds like a fun way to spend time \. You like watching movies \.) (100 :out)
      ))


)
