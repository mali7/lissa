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
;;   (what is your major ?)
;;   (what was your favorite class ?)
;;   (did you find your favorite class hard ?)
;;   (my favorite class was AI)
;;   (How long have you been in Rochester ?)
;;   (What do you like about Rochester ?)
;;   (What do you not like about Rochester ?)
;;   (What would you change in Rochester ?)
;;   (What would we do on a tour of Rochester ?)
;;   (What is your favorite restaurant in Rochester ?)
;;   (What kind of food is a garbage plate ?)
;;   (have you been to the Dinosaur Barbecue ?)
;;   (Do you like watching TV and movies\, or reading books ?)
;;   etc. (others to be added)

(eval-when (load eval)

(mapc 'attachfeat ; needed for detecting alternatives in the
                  ; watching-or-reading question
  '((spare-time-activity sports read reading watch watching play
     playing hike hiking explore exploring walk walking walks hobby
     hobbies painting); others? "make", "build" seem too general
   ))

(READRULES '*reaction-to-input*
  ; Choose between reaction to a question and an assertion
  ; Only one gist clause is expected here
 '(1 (0 wh_ nil you 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 aux you{r} 0)
    2 *reaction-to-question* (0 :subtree)
   ;1 (0 aux you 0)
   ; 2 *reaction-to-question* (0 :subtree)
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
; e.g., (I am a physics major \.), with words expanded to feature lists
 '(1 (0 My major 0) 
    2 *reaction-to-major-input* (0 :subtree )
; e.g., (I do not have a major yet \.)
   1 (0 I 0 not 0 major 0)
    2 *reaction-to-major-input* (0 :subtree)

; e.g., (my favorite subject is cognitive science \.)
   1 (0 my favorite class 0)
    2 *reaction-to-favorite-class-input* (0 :subtree)
; e.g., (I do not have a favorite subject \.)
   1 (0 I 0 not 1 have 1 favorite class 0)
    2 *reaction-to-favorite-class-input* (0 :subtree)

; e.g., (I did not find it hard)
   1 (0 not 2 favorite class 0 hard 0)
    2 *reaction-to-hardness-of-class-input* (0 :subtree)
   1 (0 favorite class 0 hard 0)
    2 *reaction-to-hardness-of-class-input* (0 :subtree)

; e.g., (I have been in Rochester for three years \.)
   1 (0 I 0 been in Rochester 0)
    2 *reaction-to-how-long-in-rochester-input* (0 :subtree)

; e.g., (I do not like the weather in Rochester \.)
;       We try this before "likes", so as to catch any negation
   1 (0 I do not like 0 Rochester 0) 
    2 *reaction-to-not-like-about-rochester-input* (0 :subtree)
; e.g., (I like the restaurants in Rochester)
   1 (0 I like 0 Rochester 0)
    2 *reaction-to-like-about-rochester-input* (0 :subtree)

; e.g., (I would renovate the downtown area \.)
   1 (0 I would change 0)
    2 *reaction-to-changing-rochester-input* (0 :subtree)

; e.g., (I would go to the Eastman House \.)
   1 (0 I would take you 0)
    2 *reaction-to-tour-of-rochester-input* (0 :subtree)

; e.g., (My favorite restaurant is the Dinosaur Grill \.)
   1 (0 My favorite 2 restaurant 0)
    2 *reaction-to-favorite-eatery-in-rochester-input* (0 :subtree)

; e.g., (I describe the garbage plate \.)
   1 (0 garbage plate 0)
    2 *reaction-to-garbage-plate-input* (0 :subtree)

; e.g., (I have not been to Dinosaur Barbecue)
   1 ( 0 Dinosaur Barbecue 0)
    2 *reaction-to-dinosaur-bbq-input* (0 :subtree)

; e.g., (I do not like watching movies very much \.)
   1 (0 I 0 not like watching 0)
    2 *reaction-to-watching-or-reading-input* (0 :subtree)
   1 (I like watching 0)
    2 *reaction-to-watching-or-reading-input* (0 :subtree)

; e.g., (I do not like reading \.)
   1 (0 I 0 not like books 0)
    2 *reaction-to-watching-or-reading-input* (0 :subtree)
   1 (0 I 0 like books 0)
    2 *reaction-to-watching-or-reading-input* (0 :subtree)

; e.g., (I like sports \.); other activities (previous matches failed)
   1 (I like 0 spare-time-activity 0)
    2 *reaction-to-watching-or-reading-input* (0 :subtree)

   1 (0 favorite movie genre 0)
    2 *reaction-to-movie-genre-input* (0 :subtree)

   1 (0 my favorite movie 0)
    2 *reaction-to-favorite-movie-input* (0 :subtree)

   1 (0 seen the new Star Wars 0)
    2 *reaction-to-seen-star-wars-input* (0 :subtree)
   
   1 (0 I 3 not like Netflix 0)
    2 *reaction-to-theater-versus-netflix-input* (0 :subtree)
   1 (0 I 3 like Netflix 0)
    2 *reaction-to-theater-versus-netflix-input* (0 :subtree)

; e.g., (You are dumb), with features; various unexpected inputs
;       (This e.g., might be based on subpattern (0 you stupidthing 0))
   ;1 (0)
   ; 2 (*user-thanks-schema* nil) (0 :schema+args)
   ))

(READRULES '*reaction-to-question*
  ; Very rough initial attempt. Here I decided to directly
  ; supply reactions, though we might instead supply specialized
  ; choice trees named, e.g., '*reaction-to-reciprocal-like-about-
  ; rochester-question*', and so on ...
  ;
  ; First, some responses to reciprocal queries (with much room
  ; for improvement!):
 '(1 (0 Do you find your major hard 0); reciprocal query
      ; latency = 100 so that a second run may give different output;
    2 (Sure\, it isn\'t easy\, but it\'s fun for you \.) (100 :out)
   1 (0 what year of study are you in 0); reciprocal query
    2 (You told me \, you am a senior\. ) (100 :out)
   1 (0 what is your major 0); reciprocal query
    2 (you told me \, you study computer science \. ) (100 :out)
   1 (0 Did you find 1 favorite class hard 0)
    2 (well\, it required hard work\, but you find it enjoyable\.) (100 :out)
   1 (0 How long have you been 2 Rochester 0); reciprocal query
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
    2 (You\'ve heard about various places\, but haven\'t seen much\.)
      (100 :out)
    2 (You\'re still learning about various places to eat\.) (100 :out)
   1 (0 Have you heard of that restaurant 0)
    2 (You have heard of it but you have not been there \.) (100 :out)
   1 (0 Have you been to that restaurant 0)
    2 (You have heard of it but you have not been there \.) (100 :out)
   1 (0 Have you tried garbage plate 0)
    2 (No but you are actually curious to try it \.) (100 :out)
   1 (0 Have you been to Dinosaur Barbecue 0); reciprocal query
    2 (Well\, just in your imagination\.) (100 :out)
    2 (No\, but you\'ve been told about it\.) (100 :out)
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
    2 (Well\, you\'re the brainchild of some real people\, and they
       certainly can eat!) (100 :out)
   1 (0 How old are you 0)
    2 (That\'s no question to ask a lady!) (100 :out)
    2 (younger than me \, you believe!) (100 :out)
   1 (0 Where are you from 0)
    2 (You\'re from a place I\'ve probably never heard of -- Maida Vale\.) (100 :out)
                                  ; that's Turing's birthplace^^^^^^^^
    2 (Your parents are always on the move\, so you're from nowhere in
       particular\.) (100 :out)
   1 (0)
     2 (Mmmm\.\.\. I\'m not sure \. ) (100 :out)
      
 ))

 (READRULES '*reaction-to-unexpected*
   '(1 (0 thank you 0)
      2 *user-thanks-schema* (0 :schema))
 )
 
)

