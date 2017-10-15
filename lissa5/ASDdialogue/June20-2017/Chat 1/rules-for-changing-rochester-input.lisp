(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((safety crime dangerous safe neighborhood neighborhoods ward safer)
          (anything nothing)
		  (transportation bus buses)
		  (weather cold snow snows snowy winter warmer)
		  (entertainments entertainment entertaining exciting)
		  (modern new renovate)
		  ))
       
 
 (READRULES '*specific-answer-from-changing-rochester-input*
 '(1 (0 NEG 0 anything 0) 
	  2 ((There is nothing that I would change in Rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 no 0) 
	  2 ((There is nothing that I would change in Rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 not 1 really 0)  
          2 ((There is nothing that I would change in Rochester \.)  (Rochester-enhancements)) (0 :gist)  
	1 (0 I wish 1 0) 
	  2	((I would change it so that 4 \.) (Rochester-enhancements)) (0 :gist)
	1 (0 entertainment 0)  
	  2 ((I would change it by adding some entertainments \.) (Rochester-enhancements)) (0 :gist)
	1 (0 weather 0)
       2 ((I would change the weather in Rochester \.) (Rochester-enhancements)) (0 :gist)    
	1 (0 spring 0)
       2 ((I would change the weather in Rochester \.) (Rochester-enhancements)) (0 :gist)    
	1 (0 safety 0) 
	  2 ((I would change Rochester to be safer \.) (Rochester-enhancements)) (0 :gist)
    1 (0 transportation 0) 
	  2 ((I would change the transportation system in Rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 modern 0) 
	  2 ((I would change the old things in Rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 no opinion 0) 
	  2 ((I have no opinion about what I would change in Rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 I 2 happy with 0) 
	  2 ((There is nothing that I would change in Rochester \.)  (Rochester-enhancements)) (0 :gist)
	
	1 (0 3 0) 
	  2 ((Nothing found for what I would change in Rochester \.)  (Rochester-enhancements)) (0 :gist)))
 
 (READRULES '*thematic-answer-from-changing-rochester-input*
    '())

 (READRULES '*unbidden-answer-from-changing-rochester-input*
	())

 (READRULES '*question-from-changing-rochester-input* 
    '(1 (0 what 0 you 0)
		2 (what would you change about Rochester ?) (0 :gist)
      1 (0 how 0 you 0)
        2 (what would you change about Rochester ?) (0 :gist)
     ))
 
 (READRULES '*reaction-to-changing-rochester-input*  
 '(1 (0 nothing that I 1 change 0)  
	  2 (It seems I am content \.) (100 :out)
	1 (0 weather 0) 
	  2 (Not much we can do about it!) (100 :out)
	1 (0 safer 0) 
	  2 (It would be great if the city will be safer than it is right now \.) (100 :out)
    1 (0 transportation 0) 
	  2 (It would be great if buses become more frequent \.) (100 :out)
    1 (0 old 0) 
	  2 (It would be great if the city gets renovated \.) (100 :out)
    1 (0 no opinion 0)  
      2 (I would change the weather in winter if I could \.) (100 :out)	  
    1 (0 exciting 0)  
      2 (That would be a lot of fun \.) (100 :out)	  
    1 (0 I would change it so that 0) 
      2 (Yeah\, you see \.) (100 :out) 
	1 (0 nothing found 0) 
      2 (Yeah\, you see \.) (100 :out) 
	)); end of *reaction-to-changing-rochester-input*
	  
); end of eval-when