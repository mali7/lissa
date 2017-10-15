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
;; (what city would you want to move to next ?) --
;; (why is that city special for you ?) 
;; (What kind of home would you want to live in ?)
;; (where would you live if money was not a concern ?)
;; (what would your dream home be like ?)
;; (what would your crazy room be like ?)
;; (where did you grow up ?)
;; (what is the biggest difference between your hometown and Rochester ?) 
;; (what do you miss about your hometown ?)
;; (what do you like better in Rochester ?)
;; (do you stay in touch with any of your friends from home ?)
;; (what are your plans after you graduate ?)
;; (what is your dream job ?) 
;; (what do you think about work friends ?) 


(eval-when (load eval)

(mapc 'attachfeat ; needed for detecting alternatives in the
                  ; watching-or-reading question
  '())

(READRULES '*reaction-to-input*
  ; Choose between reaction to a question and an assertion
  ; Only one gist clause is expected here
 '(1 (0 wh_ nil you{r} 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 aux you{r} 0)
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
; e.g., (I want to move to New York City \.), with words expanded to feature lists
 '(1 (0 I want to move to 0) 
    2 *reaction-to-city-want-to-move-input* (0 :subtree )
; e.g., (I want to stay here \.)
   1 (I want 0 stay here 0)
    2 *reaction-to-city-want-to-move-input* (0 :subtree)

; e.g., (That city is special for me because ... \.)
   1 (0 The city is special for me 0)
    2 *reaction-to-special-about-city-input* (0 :subtree)

; e.g., (I like to live in an apartment )
   1 (0 I like to live in 0)
    2 *reaction-to-home-want-to-live-input* (0 :subtree)

; e.g., (If money was not an issue I would live in Miami \.)
   1 (0 If money was not an issue 1 I would live 0)
    2 *reaction-to-ideal-place-to-live-input* (0 :subtree)

; e.g., (My dream home is a home on a water with a boat) 
   1 (0 My dream home is 0) 
    2 *reaction-to-dream-home-input* (0 :subtree)

; e.g., (My crazy room is a room with video games) 
   1 (0 My crazy room is 0)
    2 *reaction-to-crazy-room-input* (0 :subtree)

; e.g., (My hometown is DC \.)
   1 (0 I grew up in 1 0)
    2 *reaction-to-hometown-input* (0 :subtree)

; e.g., (The biggest difference between my hometown and Rochester is that Rochester is cold \.)
   1 (0 The biggest difference between my hometown and Rochester 0)
    2 *reaction-to-rochester-hometown-difference-input* (0 :subtree)

; e.g., (What I missed about my hometown is my friends \.)
   1 (0 What I missed about my hometown is 0)
    2 *reaction-to-miss-about-hometown-input* (0 :subtree)

; e.g., (What I like better in Rochester is that people are nice)
   1 (0 What I like better in Rochester 0)
    2 *reaction-to-like-better-in-Rochester-input* (0 :subtree)

; e.g., (I am in touch with my friends from home\.)
   1 (I am not in touch with my friends from home 0)
    2 *reaction-to-friends-from-home-input* (0 :subtree)
   1 (I am in touch with my friends from home 0)
    2 *reaction-to-friends-from-home-input* (0 :subtree)

; e.g., (My plan after graduation is to work in google \.)
   1 (0 My plan after graduation is 0)
    2 *reaction-to-plans-after-graduation-input* (0 :subtree)

; e.g., (My dream job is..)
   1 (0 My dream job is 0)
    2 *reaction-to-dream-job-input* (0 :subtree)

   1 (0 I think 1 work friends 0)
    2 *reaction-to-work-friends-input* (0 :subtree)

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
  
  ; First, some responses to reciprocal queries (with much room
  ; for improvement!):
 
 '(1 (0 what city 0 want to move 0); reciprocal query
    2 (Well\, you like big cities in which one can find so many things to do\. You would live in New York City \. So ) (100 :out)
   1 (0 why 2 city special for you 0); reciprocal query
    2 (You like to live in New York City because there are always something to do there \.) (100 :out)
   1 (0 what kind 2 home 2 want to live 0); reciprocal query
    2 (You prefer a modern appartment \, like one of those smart homes \.) (100 :out)
   1 (0 where would you live 2 money 0); reciprocal query
    2 (A home near a lake is your ideal home\.) (100 :out)
   1 (0 what 2 dream home 0); reciprocal query 
    2 (A big home in a silent area near a beautiful lake is your ideal home \.)
      (100 :out)
   1 (0 what 2 crazy room 0); reciprocal query
    2 (Well\, you like a room full of all kind of video games \.) (100 :out)
   1 (0 where 2 grow up 0); reciprocal query
    2 (You\'re from a place I\'ve probably never heard of -- Maida Vale\.) (100 :out)   ; that's Turing's birthplace
    2 (Your parents are always on the move\, so you\'re from nowhere in
       particular\.) (100 :out)
   1 (0 what 2 biggest difference 2 hometown 1 Rochester 0); reciprocal query
    2 (Rochester is definitely the coldest place you have ever been \.) (100 :out)  
   1 (0 what 2 you like better 1 Rochester 0); reciprocal query
    2 (You like people here\, they are so nice \.) (100 :out)   
   1 (0 what 0 plans after 1 graduate 0); reciprocal query
    2 (You want to get your PhD \.) (100 :out)
   1 (0 you have any friend 0); reciprocal query
    2 (You have a lot of virtual friends which you are talk with them every other day \.) (100 :out)
   1 (0 Do you stay in touch 3 your friends 1 home 0)
    2 (You have a lot of virtual friends which you are talk with them every other day \.) (100 :out)
	
   ; Some sample responses to miscellaneous queries from the user
   ; (needing a great deal of expansion):
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
    2 (Your parents are always on the move\, so you\'re from nowhere in
       particular\.) (100 :out)
 ))

 (READRULES '*reaction-to-unexpected*
   '(1 (0 thank you 0)
      2 *user-thanks-schema* (0 :schema))
 )
 
)

