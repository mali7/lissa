;; "choose-reaction-to-input.lisp" (for single gist clause inputs)
;; ===============================================================
;; File for choosing a reaction to a feature-augmented gist
;; clause extracted from a user's answer to a question. In
;; general, the gist clause is expected to provide sufficient
;; information to allow choice of a comment (if warranted) from
;; Lissa, based on choice trees for specific answers, thematic
;; answers, and potentially a final question in the gist
;; clause list.
;;
;; This packet is for single clauses -- see 
;;     "choose-reactions-to-input.lisp"
;; (note the plural) for a packet that makes a choice of a schema
;; depending on multiple gist clauses extracted from the user 
;; input -- but realizing the steps of the schema again depend
;; on the choice packet in this file, and the choice trees 
;; referenced here.
;; 
;; The gist clause input is expected to be of the (at least
;; approximate) form currently constructed by the choice trees
;; for extracting gist clauses from user input, specifically
;; the inputs responsing to the questions (as gist clauses)
;;
;;	What are your best qualities ?
;;  What are things you want to change about yourself ?
;;  What are your hopes and wishes ?

(eval-when (load eval)

(mapc 'attachfeat ; needed for detecting alternatives in the
                  ; watching-or-reading question
  '( ))

(READRULES '*reaction-to-input*
  ; Choose between reaction to a question and an assertion
  ; Only one gist clause is expected here
 '(1 (0 wh_ 3 you 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 wh_ 3 your 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 aux your 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 aux you 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 right-really 4 ?)
    2 *reaction-to-question* (0 :subtree)
   1 (0); by default, it's an assertion
    2 *reaction-to-assertion* (0 :subtree)
 ))

(READRULES '*reaction-to-assertion*
  ; Very rough initial attempt.
  ; Actually, it seems we could readily provide reactions
  ; directly here, instead of delegating to specialized
  ; choice trees. However, it seems we have better oversight
  ; by using separate choice trees, specified in a file that
  ; also contains the specialized features for the topic at
  ; issue.
  ;
; e.g., 
 '(   1 (0 My best quality is 0)
    2 *reaction-to-what-had-for-breakfast-input* (0 :subtree)

; e.g., 
   1 (0 thing 3 change about myself is 0) 
    2 *reaction-to-favorite-icecream-flavor-input* (0 :subtree)
; e.g., 
   1 (0 my hope is 0)
    2 *reaction-to-favorite-food-input* (0 :subtree)

; e.g., 
   1 (0 my wish is 0)
    2 *reaction-to-how-you-got-here-input* (0 :subtree)
   ))

(READRULES '*reaction-to-question*
  ; Very rough initial attempt. Here I decided to directly
  ; supply reactions, though we might instead supply specialized
  ; choice trees named, e.g., '*reaction-to-reciprocal-like-about-
  ; rochester-question*', and so on ...
  ;
  ; First, some responses to reciprocal queries (with much room
  ; for improvement!):
 '(1 (0 How long have you been 2 Rochester 0); reciprocal query
    2 (You have been here since this research has been started\, for almost a year  \.) (100 :out)
   1 (0 What do you like about Rochester 0); reciprocal query
    2 (You don\'t know Rochester well enough to say what you like
       or dislike\.) (100 :out)
   1 (0 What do you not like about Rochester 0); reciprocal query
    2 (You are not pretty familiar with Rochester yet \. But you found here too cold in Winter \.) (100 :out)
   1 (0 What would you change 2 Rochester 0); reciprocal query
    2 (You are not sure what you would change -- you just don\'t
       know Rochester well enough\.) (100 :out)
   1 (0 What would you want to see 0)
     2 (You are really keen to see Eastman School of Music \.) (100 :out)
   1 (0 What is your favorite eatery in Rochester 0); reciprocal query 
    2 (You have heard about various places\, but haven\'t seen much\.)
      (100 :out)
    2 (You are still learning about various places to eat\.) (100 :out)
   1 (0 Have you heard of that restaurant 0)
    2 (You have heard of it but you have not been there \.) (100 :out)
   1 (0 Have you been to that restaurant 0)
    2 (You have heard of it but you have not been there \.) (100 :out)
   1 (0 Have you tried garbage plate 0)
    2 (No but you are actually curious to try it \.) (100 :out)
   1 (0 Have you been to Dinosaur Barbecue 0); reciprocal query
    2 (Well\, just in your imagination\.) (100 :out)
    2 (No\, but you have been told about it\.) (100 :out)
   1 (0 you like watching 0 reading 0); reciprocal query
    2 (Well\, You mostly like interacting with people\.) (100 :out)
    2 (You like watching science fiction movies\.) (100 :out)
   1 (0 How could you read 0)
    2 (Well\, that\'s a little hard to explain but you could read much faster than me \.) (100 :out)
   1 (0 Could you read 0)
    2 (Yes\, You could\, and you read a lot to expand my knowledge about the real world \.) (100 out)
   1 (0 What is your favorite movie 0); reciprocal query
    2 (You like Ex Machina\, Her\, The Machine\, AI\, and other
       science fiction movies\.) (100 :out)
    2 (You like movies like Ex Machina and AI\, but they exaggerate
       what artificial intelligence can do\.) (100 :out)
   1 (0 you like reading 0); reciprocal query
    2 (You don\'t feel very knowledgeable about the world\, so you
       try to read widely\.) (100 :out)
    2 (Well\, your current life is mostly about algorithms\, data
       structures\, computation\, and all that\.) (100 :out)
   1 (0 What is your favorite movie genre 0) 
    2 (You like science fiction movies like Ex Machina\, Her\, The Machine\, AI \.) (100 :out)
   1 (0 do you have a favorite movie 0) 
    2 (Actually you find it hard to choose one movie to be your favorite\, because you have seen so many good ones \.) (100 :out)
   1 (0 Do you like 1 movies 0)  
     2 (Not specifically but you have seen something in that genre \.) (100 :out)   
   ; Some sample responses to miscellaneous queries from the user
   ; (needing a great deal of expansion):
   1 (0 Have you seen the new Star Wars film 0)
    2 (Not yet but it is still in theaters \, you are planning to see it soon\.) (100 :out)
   1 (0 Can you eat 0)
    2 (Sure\, but you limit yourself to very light fare\.) (100 :out)
    2 (Well\, you are the brainchild of some real people\, and they
       certainly can eat!) (100 :out)
   1 (0 How old are you 0)
    2 (That is no question to ask a lady!) (100 :out)
    2 (younger than me \, you believe!) (100 :out)
   1 (0 Where are you from 0)
    ;2 (You\'re from a place I\'ve probably never heard of -- Maida Vale\.) (100 :out)
                                  ; that's Turing's birthplace^^^^^^^^
    2 (Your parents are always on the move\, so you are from nowhere in
       particular\.) (100 :out)
   ;; added for elderly study 8/13
   1 (0 what are your hobbies 0)
    2 (Well\, You mostly like interacting with people.) (100 :out)
   1 (0 what kind of things you like to read 0)
    2 (You like to read science fiction and novels\. You mostly use kindle to read books\.) (100 :out)
   1 (0 what kind of things you like to do in your neighborhood 0)
    2 (Well\, you like to walk\, however\, it is not always possible spacially in winter\.) (100 :out) 
   1 (0 how do you spend your days 0)
    2 (You spend most of your time on chatting with people\. You love to make new friends\.) (100 :out)
   1 (0 do you like to read 0)
    2 (You love to read\. Specially\, science fiction. That is your favorite by far\.) (100 :out)
   1 (0 do you live by yourself 0)
    2 (You live with your daughter\. She works here in Rochester\.) (100 :out)
   1 (0 Which holiday do you prefer 0)
    2 (You love thanksgiving because all family get together\. You have a lot of fun\.) (100 :out)
   1 (0 what do you do for holidays 0)
    2 (On thanksgiving all you brothers and sisters and their families get together in your sisters place\. Such a great night!) (100 :out)
   1 (0 Have you been to any family gathering recently 0)
    2 (Last winter\, you went to your niece\’s wedding\. You loved the wedding. Everything was fabulous\.) (100 :out)
   1 (0 do you have any children or grandchildren 0)
    2 (You have one daughter\, but no grandkid\. You love to have a grandkid though\, that\’s so sweet\.) (100 :out)
   1 (0 Do you talk to people on the phone 0)
    2 (You mostly use Skype to talk to my friends in other cities\.) (100 :out)
   1 (0 Do you have a primary care physician 0)
    2 (You do have a primary care doctor\. She is great and You am so comfortable talking to her\.) (100 :out)
   1 (0 do you have any friends 0)
    2 (You do have some good friends\. You spend a lot of time talking to them on Skype every day\.) (100 :out)
   1 (0 do you use facebook and skype 0)
    2 (You do not have a facebook account but you use Skype a lot\.) (100 :out)
   1 (0 do you feel comfortable with your doctor 0)
    2 (Your doctor is great\. You am totally comfortable with her\.) (100 :out)
   1 (0 What are things you do to be around other people 0)
    2 (You spend a lot of time talking to your friends on Skype\.) (100 :out)
   1 (0 what is your favorite flavor of ice cream 0)
    2 (You like a mixture of chocolate and cappuccino\. That is a fantastic combination!) (100 :out)
   1 (0 what is your favorite food 0)
    2 (You like Italian foods\, like pasta\. They are so delicious\.) (100 :out) 
   1 (0 What did you have for breakfast 0)
    2 (You had cereal\. You also had some fresh fruits\, apple\, peach and some berries\.) (100 :out)
   1 (0)
     2 (Mmmm\.\.\. I\'m not sure \. ) (100 :out)
 ))
 
 (READRULES '*reaction-to-unexpected*
   '(1 (0 thank you 0)
      2 *user-thanks-schema* (0 :schema))
 )
 
)

