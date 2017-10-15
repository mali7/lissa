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
 '(1 (0 nothing that I would change 0)
  2 (It\'s good to be content with how things are\.) (100 :out)
1 (0 change it so that 0)
  2 (That sounds like it would be nice\.) (100 :out)
1 (0 entertainments 0)
  2 (Yeah\, it can get quiet here\. It\'s good to have hobbies to keep yourself occupied\.) (100 :out)
1 (0 weather 0)
  2 (It is a snowy place\. Stay warm!) (100 :out)
1 (0 safer 0)
  2 (Be sure to stay safe\.) (100 :out)
1 (0 transportation 0)
  2 (It is hard to get around sometimes\.) (100 :out)
1 (0 old things 0)
  2 (Things do change\, don\'t they\.) (100 :out)
1 (0 no opinion 0)
  2 (Okay\, it\'s good to be generally content\.) (100 :out)
1 (nothing found 0)
  2 (Okay\.) (100 :out)
)); end of *reaction-to-changing-rochester-input*
	  
); end of eval-when