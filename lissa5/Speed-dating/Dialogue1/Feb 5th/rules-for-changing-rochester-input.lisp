(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((safety crime dangerous safe neighborhood neighborhoods ward safer)
          (anything nothing)
		  (transportation bus buses)
		  (weather cold snow snows snowy winter)
		  ))
       
 
 (READRULES '*specific-answer-from-changing-rochester-input*
 '(1 (0 NEG 0 anything 0) 
	  2 ((There is nothing that I would change about Rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 not 1 really 0)  
          2 ((There is nothing that I would change about Rochester \.)  (Rochester-enhancements)) (0 :gist)  
	1 (0 I wish 1 0) 
	  2	((I would change it so that 4 \.) (Rochester-enhancements)) (0 :gist)
	1 (0 not 2 much to do 0)  
	  2 ((I would try to make things more exciting \.) (Rochester-enhancements)) (0 :gist)
	1 (0 nothing 1 to do 0)  
	  2 ((I would try to make things more exciting \.) (Rochester-enhancements)) (0 :gist)
        1 (0 weather 0)
          2 ((I would change the weather in Rochester \.) (Rochester-enhancements)) (0 :gist)    
	1 (0 safety 0) 
	  2 ((I would change Rochester to be safer \.) (Rochester-enhancements)) (0 :gist)
    1 (0 transportation 0) 
	  2 ((I would change Rochester in transportation improvement \.)  (Rochester-enhancements)) (0 :gist)))
 
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
 '(1 (0 not like 0 not much to do 0)  
	  2 (That bothers you too \.) (100 :out)
	1 (0 weather 0) 
	  2 (Yeah\, the weather sometimes makes you crazy \.) (100 :out)
	1 (0 not safe 0) 
	  2 (Yeah \, you also find it bothering \.) (100 :out)
    1 (0 transportation 0) 
	  2 (Yeah\, you wish that transportation system was better \.) (100 :out)
    1 (0 anything 0) 
	  2 (It seems I am content \.) (100 :out)
    1 (0 old 0) 
	  2 (Right\, you have the same feeling \.) (100 :out)
    1 (0 no opinion 0)  
      2 (It seems I am kind of content \.) (100 :out)	  
    1 (0 I would change it so that 0) 
      2 (That is a great idea \.) (100 :out) 
	)); end of *reaction-to-changing-rochester-input*

); end of eval-when