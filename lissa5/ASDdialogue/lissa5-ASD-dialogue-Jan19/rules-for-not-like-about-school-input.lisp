; not-like-about-school


(eval-when (load eval)
  (mapc 'attachfeat '(
    (bully tease pick bullied teased picked)
    (hard work frustrating challenging difficult)
    (bored boring)
    (school-subject math science english writing reading history social
         biology chemistry algebra arithmetic physics recess music orchestra band
         chorus drama gym PE literature spanish french latin german japanese chinese)
  ))


  (readrules '*specific-answer-from-not-like-about-school-input*
    '(1 (0 not 2 much to do 0)  
        2 ((What I dislike about school is that I find myself bored in school \.) (school-dislike)) (0 :gist)
      1 (0 nothing 2 to do 0)  
        2 ((What I dislike about school is that I find myself bored in school \.) (school-dislike)) (0 :gist)
      1 (0 bored 0)
        2 ((What I dislike about school is that I find myself bored in school \.) (school-dislike)) (0 :gist)    
      1 (0 hard 0)
        2 ((What I dislike about school is that I find schoolwork hard to do \.) (school-dislike)) (0 :gist)
      1 (0 bully 0)
        2 ((What I dislike about school is that I\'m bullied in school \.) (school-dislike)) (0 :gist)
      1 (6 school-subject teacher 0)
        2 ((What I dislike about school is that I don\'t like my 2 teacher \.) (school-dislike)) (0 :gist)
      1 (7 teacher 0)
        2 ((What I dislike about school is that I don\'t like my teacher \.) (school-dislike)) (0 :gist)
      1 (8 school-subject 0)
        2 ((What I dislike about school is that I don\'t like 2 \.) (school-dislike)) (0 :gist)
      1 (0 anything 0)
        2 ((no opinion about what I dislike about school \.) (school-dislike)) (0 :gist)
      1 (0 not 1 really 0)
        2 ((no opinion about what I dislike about school \.) (school-dislike)) (0 :gist)   
      ))


  (readrules '*thematic-answer-from-not-like-about-school-input*
    '())


  (readrules '*unbidden-answer-from-not-like-about-school-input*
    '(1 (0 bully 0)
        2 ((Someone is bullying me in school \.) (bullying)) (0 :gist)))


  (readrules '*question-from-not-like-about-school-input*
    '())

  (readrules '*reaction-to-not-like-about-school-input*
    '(1 (0 bored 0)
        2 (Just wait till you\'re old enough to go to the DMV \.) (100 :out)
      1 (0 hard 0)
        2 (Schoolwork can be hard\, but it\'s worth the effort \.) (100 :out)
      1 (0 bullied 0)
        2 (I\'m sorry that\'s happening \. That isn\'t good of them \.) (100 :out)
      1 (0 teacher 0)
        2 (You didn\'t get along with all of your teachers either \. Sometimes I have to work with people I don\'t always fit well with in life \.) (100 :out)
      1 (0 school-subject 0)
        2 (2 can be rough \. You hope you\'re getting help if I need it \.) (100 :out)
      1 (no opinion 0)
        2 (You mostly liked school when you was my age \.) (100 :out)
      1 (That would bother you too) (100 :out)
      ))

)

