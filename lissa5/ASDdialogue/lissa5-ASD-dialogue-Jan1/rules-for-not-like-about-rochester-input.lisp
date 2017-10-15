; not-like-about-rochester


(eval-when (load eval)
  (mapc 'attachfeat '(
    (old rundown)
    (safety crime dangerous safe neighborhood neighborhoods ward safer)
    (anything nothing)
    (transportation bus buses)
    (weather cold snow snows snowy winter)
  ))


  (readrules '*specific-answer-from-not-like-about-rochester-input*
    '(1 (0 not 2 much to do 0)  
        2 ((I do not like that there is not much to do in Rochester \.) (rochester-dislike)) (0 :gist)
      1 (0 nothing 2 to do 0)  
        2 ((I do not like that there is not much to do in Rochester \.) (rochester-dislike)) (0 :gist)
      1 (0 weather 0)
        2 ((I do not like the weather in Rochester \.) (rochester-dislike)) (0 :gist)    
      1 (0 safety 0) 
        2 ((I do not like that some places are not safe in Rochester \.) (rochester-dislike)) (0 :gist)
      1 (0 transportation 0) 
        2 ((I do not like the transportation in Rochester \.) (rochester-dislike)) (0 :gist)
      1 (0 anything 0) 
        2 ((There is nothing that I do not like in Rochester \.) (rochester-dislike)) (0 :gist)
      1 (0 old 0) 
        2 ((I do not like old places in Rochester \.) (rochester-dislike)) (0 :gist)
      1 (0 not 1 really 0)  
        2 ((no opinion about what I do not like in Rochester \.) (rochester-dislike)) (0 :gist)   
      1 (0 I wish 1 the 1 0) 
        2 ((I do not like 4 in Rochester \.) (rochester-dislike)) (0 :gist)
      ))


  (readrules '*thematic-answer-from-not-like-about-rochester-input*
    '())


  (readrules '*unbidden-answer-from-not-like-about-rochester-input*
    '())


  (readrules '*question-from-not-like-about-rochester-input*
    '(1 (0 what 0 you 0)
        2 (what do not you like about Rochester ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what do not you like about Rochester ?) (0 :gist)
      1 (0 what 2 not you like 0)
        2 (what do you like about Rochester ?) (0 :gist)
      ))


  (readrules '*reaction-to-not-like-about-rochester-input*
    '(1 (0 not like 0 not much to do 0)  
        2 (That bothers you too \.) (100 :out)
      1 (0 weather 0) 
        2 (Yeah\, you find it cold here too\.) (100 :out)
      1 (0 not safe 0) 
        2 (Yeah \, you also find it bothering \.) (100 :out)
      1 (0 transportation 0) 
        2 (Yeah\, you wish that transportation system was better \.) (100 :out)
      1 (0 anything 0) 
        2 (It seems I are content \.) (100 :out)
      1 (0 old 0) 
        2 (Right\, you have the same feeling \.) (100 :out)
      1 (0 no opinion 0)  
        2 (It seems I are kind of content \.) (100 :out)    
      1 (That would bother you too) (100 :out)
      ))


)
