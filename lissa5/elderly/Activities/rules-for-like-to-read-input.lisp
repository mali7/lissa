(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((yes yeah)
    (book-genre novel novels magazines magazine health 
	mystery mysteries fictions fiction non-fictions non-fiction romance historical detective
	humor biographies autobiography art Literature Philosophy Religion Ethics
	newspaper horror satire diaries cookbooks cookbook poetry)
	))
;; (do you like to read ?)
;;	(like-to-read)
;;		from-like-to-read-input
;;			(0 I do not like reading 0) (0 I like reading 0)
;;			gist-question:(3 do 1 like to read 0)

 (READRULES '*specific-answer-from-like-to-read-input*
   '(1 (2 book club 0) 
        2 ((I like reading in book club \.)  (like-to-read)) (0 :gist) 		
     1 (2 library 0) 
        2 ((I like reading in library \.)  (like-to-read)) (0 :gist) 		
     1 (2 kindle 0) 
        2 ((I like reading on kindle \.)  (like-to-read)) (0 :gist) 		
     1 (2 NEG 0) 
        2 ((I do not like reading \.)  (like-to-read)) (0 :gist) 		
     1 (1 I do not 0) 
        2 ((I do not like reading \.)  (like-to-read)) (0 :gist) 		
     1 (2 yes 0) 
        2 ((I like reading \.)  (like-to-read)) (0 :gist) 		
     1 (like to 0) 
        2 ((I like reading \.)  (like-to-read)) (0 :gist) 		
     1 (0 like to read 0) 
        2 ((I like reading \.)  (like-to-read)) (0 :gist) 		
     1 (0 I 3 reader 0) 
        2 ((I like reading \.)  (like-to-read)) (0 :gist) 		
     1 (0 listen 3 book 0) 
        2 ((I like reading and listening to audio books \.)  (like-to-read)) (0 :gist) 		
   ))
       
       
 (READRULES '*thematic-answer-from-like-to-read-input*
    '())

 (READRULES '*unbidden-answer-from-like-to-read-input*
    '())
		
 (READRULES '*question-from-like-to-read-input*
    '(1 (0 what 2 you 0)
        2 (do you like to read ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (do you like to read ?) (0 :gist)
	  1 (0 do you 2 like 2 read 0)
        2 (do you like to read ?) (0 :gist)
      1 (0 do you 2 read 0)
        2 (do you read ?) (0 :gist)
     ))

(READRULES '*reaction-to-like-to-read-input*
   '(1 (0 like reading 0)
       2 (0 book club 0)
         3 (Being in a book club is fun! It\'s also a good place to socialize\.) (100 :out)
       2 (0 library 0)
         3 (You like going to the library\. It\'s always fun to find a new book\.) (100 :out)
       2 (0 kindle 0)
         3 (That sounds nice\. You personally like kindle better\, but some people still prefer paper books\.) (100 :out)
       2 (0 audio books 0)
         3 (That\'s nice\. You like listening to audio books in the car\.) (100 :out)
       2 (Reading is a lot of fun\. You enjoy it too\.) (100 :out)
     1 (0 do not like reading 0)
       2 (That\'s fine\, there are plenty of other fun things to do\.) (100 :out)
	))
); end of eval-when
