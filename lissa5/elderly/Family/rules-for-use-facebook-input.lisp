(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((yes yeah)
    (social-networks facebook account profile page skype skyping facetime) ;; here
    (other-communication email emailing mail mailing text texting phone)
	  (use used)  ;here
   ))
;;	(Do you use facebook or skype ?)
;;	(use-facebook)
;;		from-use-facebook-input
;;			(0 I do not use facebook 1 skype 0) (0 I use facebook 1 skype 0)
;;			gist-question: (3 do you 1 facebook 0)

 (READRULES '*specific-answer-from-use-facebook-input*
   '(
    1 (2 yes 0)
       2 ((I use facebook or skype \.)  (use-facebook)) (0 :gist)
    1 (0 I do 1 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I do have 1 social-networks 0)   ;; here : I do have a facebook account
       2 ((I use 6 \.)  (use-facebook)) (0 :gist)
    1 (0 I social-networks 0)  ;; here: I skype quite a bit with the three year old
       2 ((I use 3 \.)  (use-facebook)) (0 :gist)
    1 (0 I have 1 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I use 2 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I\'m on 1 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I am on 1 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (2 NEG 1 use 0)  ;; here   for example: "Yes I do facebook. I don’t post too much about myself..." 
						;; generally relying only on NEG is dangerous because it might match 
						;; to any negative verb the user use throughout their response
	   2 ((I do not use facebook or skype \.)  (use-facebook)) (0 :gist)
    1 (1 I do not 1 social-networks 0)
       2 ((I do not use facebook or skype \.)  (use-facebook)) (0 :gist)
    1 (0 don\'t 2 social-networks 0)
       2 ((I do not use facebook or skype \.)  (use-facebook)) (0 :gist)
    ))
       
 (READRULES '*thematic-answer-from-use-facebook-input*
    '())

 (READRULES '*unbidden-answer-from-use-facebook-input*
    '(
      ; Should I add something about email here, e.g. "I do not use facebook, but
      ; I do use email to keep in touch" ?
	  
	  ;; Yes, that's a good idea
	  ;; also some people mentioned that they have facebook account
	  ;; but they don't post anything on it (they only use it to see pictures of their grands)
	  ;; something like "I do not post on facebook" can be a bidden answer

	  1 (0 I do 1 other-communication 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I do have 1 other-communication 0)
       2 ((I use 6 \.)  (use-facebook)) (0 :gist)
    1 (0 I other-communication 0)
       2 ((I use 3 \.)  (use-facebook)) (0 :gist)
    1 (0 I have 1 other-communication 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I use 2 other-communication 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I do not 1 post 0)
       2 ((I do not post on facebook \.) (use-facebook)) (0 :gist)
    1 (0 I don\'t 1 post 0)
       2 ((I do not post on facebook \.) (use-facebook)) (0 :gist)
    ))
		
 (READRULES '*question-from-use-facebook-input*
    '(
    1 (0 what 2 you 0)
       2 (do you use facebook or skype ?) (0 :gist) ;; here: it is a good idea to use the  
													;; exact wording of the gist of LISSA question 
													;; for user's reciprocal questions (mostly because of consistency)
    1 (0 how 2 you 0)								;; (the gist has been provided above- the first line of comments )
       2 (do you use facebook or skype ?) (0 :gist)
	  1 (0 do you 2 facebook 0)
       2 (do you use facebook or skype ?) (0 :gist)
    ))

(READRULES '*reaction-to-use-facebook-input*
   '(
    1 (0 NEG 1 use 0)
       2 (You don\'t have a facebook account\, none of my friends are on it\.) (100 :out)
    1 (0 I use facebook 1 skype 0)
       2 (That\'s nice\. You have a facebook\, it makes it easier to communicate with friends\.) (100 :out)
    1 (0)
       2 (You don\'t have a facebook\, but it might be a good idea to make one to keep in touch with friends\.) (100 :out)
	))
); end of eval-when
