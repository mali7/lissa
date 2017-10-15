;; *LISSA-SCHEMA*: development version 5 (UNDER CONSTRUCTION)
;;
;; After defining *lissa-schema*, we create a hash table 
;;       *output-semantics* 
;; containing interpretations of Lissa outputs, under hash keys 
;; like (*lissa-schema* ?a1.). The main goal is to be able later
;; to match certain user inputs to question interpretations, to
;; see if the inputs already answer the questions, making them
;; redundant.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *lissa-schema*

'(Event-schema (((set of me you) have-lissa-dialog.v) ** ?e)
;```````````````````````````````````````````````````````````
; LISSA introduces herself, sets the scene, asks about the user's 
; major, responds to the user's reply, and starts the "Rochester"
; part of the dialog.

; In future, I expect something closer to the following for the
; initial LISSA dialog schema; the acions would be matched and 
; elaborated into text by a language generator:
;  (Me explain-to.v you ((nnp lissa) ((nn dialog) framework.n)))
;  (Me tell.v you (my academic-major.n))
;  (Me ask.v you (id-of (your academic-major.n)))
;  ...
; But since the eventual EL representation allows for quoting, 
; we can make life easy for ourselves at first.

; I'm not sure if the speech generator makes use of upper-/lower-case
; distinctions. If so, we'll eventually have to use character-string
; output here, and a tokenizer that changes this to special Lisp atoms
; like |Hi| I |am| |Lissa|, ... (Using ~a rather than ~s in format
; statements will output such atoms without the escape characters.)
; Note: Lisp atoms with an internal or final '.' are ok, but commas
; and semicolons are not allowed without a preceding '\' or in a |...|
; context.

:Actions ; we start execution at this keyword
         ; (I've omitted other schema components for the time being.)
         ; Lissa's lengthy initial utterance may eventually be broken into
         ; a few higher-level (nonprimitive) actions such as introducing
         ; herself, the purpose and structure of the dialog, and the 
         ; explanation of the icons, with each nonprimitive action broken 
         ; down in turn into a number of (primitive) saying-acts.
?a1. (Me say-to.v you 
      '(Hello again \, its nice to see you \. V are going to pick up our conversation where we left off\. While we talk\, the system will continue giving you feedback in the same way it gave you feedback before\.
     ))

?a2. (Me say-to.v you
      '(So I know we talked about Rochester before\. Have you thought about what city you\'d want to move to next?))

?a3. (You reply-to.v ?a2.)   ; This is a nonprimitive action by the user, to be
                             ; elaborated by creation of an action description
                             ; subordinate to '?a4.' (or rather, to a new action-
                             ; proposition name Gensym'd for ?a4.'), followed by
                             ; a (READWORDS) call that obtains the user input,
                             ; insertion of a wff of type (you say-to.v me '(...))
                             ; as the content of the subordinate action description,
                             ; and "interpretation" (expansion) of the input, where
                             ; this interpretation consists of a list of clauses
                             ; attached (as 'interpretation') to the new subordinate
                             ; action description, the first clause being the main
                             ; content (answer to Lissa's question), and the rest
                             ; being any potentially useful supplementary pieces
                             ; of information extracted from the input.

     ; At this point we want to allow for selection and insertion of 
     ; a subdialog (usually just a 1-utterance reaction, if any) that is
     ; appropriate for the user's reply, viewed as an answer to question
     ; ?a3. We branch to the right choice tree by use of the "gist clause"
     ; of the question the user has just replied to -- here '(What is your
     ; major ?)', as per ?a3. (which is referenced in ?a4.).

?a4. (Me react-to.v ?a3.); react to the "gist" of the user's input

     ; This may be particularized to a response of type '(Me say-to.v you '...).
     ; But we don't want to discard the original action specification; so it
     ; seems we want to have a link from (the name introduced for) '?a5.' to
     ; its particularization as '(Me say-to.v you '...) and possibly further
     ; actions -- a subplan. [WHAT ABOUT INTERLEAVING OF MULTIPLE PLANS
     ; AIMED AT DIFFERENT GOALS?]

?a7. (Me say-to.v you '(Why is it special to you?))

?a8. (You reply-to ?a7.) ; again leads to a (READWORDS) call, and 
                         ; formation of a subordinate 
                         ; (you say-to.v me '(...)) plan
?a10. (Me react-to.v ?a8.)

?a11. (Me say-to.v you '(And tell me more about the kind of home you would want live in\.))

?a12. (You reply-to.v ?a11.) ; again leads to a (READWORDS) call, and
                             ; formation of a subordinate
                             ; (you say-to.v me '(...)) plan

?a14. (Me react-to.v ?a12.)

?a16. (Me say-to.v you '(So what if money was not an issue and you could live anywhere in the world Where would you go?))

?a17. (You reply-to.v ?a16.)

?a19. (Me react-to.v ?a17.)

;?a20. (Me say-to.v you
;      '(And what would your dream home be like?))

;?a21. (You reply-to.v ?a20.)

;?a22. (Me react-to.v ?a21.)

?a23. (Me say-to.v you
      '(What I love about stories of rich people homes is that they always have some kind of crazy room\, a Lego room\, or a room for their hundreds of guitars\. It really gives you a sense of what they are into and what is special to them\. Like me\, I would really love a room field with video game systems\. Not just the newest ones\, but every single video game system so I would not even have to worry about plugging things in\.))

?a24. (Me say-to.v you
      '(What do you think your crazy room would be?))
      
?a25. (You reply-to.v ?a24.)

?a27. (Me react-to.v ?a25.)

?a28. (Me say-to.v you
      '(So now I know a little bit about you\, I am getting curious\, where did you grow up?))

?a29. (You reply-to.v ?a28.)

?a31. (Me react-to.v ?a29.)

?a32. (Me say-to.v you
      '(Let\'s talk more about your hometown\. What do you think is the biggest difference between your hometown and living here?))

?a33. (You reply-to.v ?a32.)

?a35. (Me react-to.v ?a33.)

;?a36. (Me say-to.v you
;      '(Tell me\, what do you miss about your hometown?))

;?a37. (You reply-to.v ?a36.)

;?a39. (Me react-to.v ?a37.)

?a40. (Me say-to.v you
      '(What do you like better here?))

?a41. (You reply-to.v ?a40.)

?a42. (Me react-to.v ?a41.) ; no choice tree here yet & perhaps inappropriate,
                            ; in view of the next Lissa output
?a43. (Me say-to.v you 
      '(Do you stay in touch with any of your friends from home ?)) ;'(Do you stay in touch with any of your friends from home?))

?a44. (You reply-to.v ?a43.)

?a46. (Me react-to.v ?a44.)

?a47. (Me say-to.v you
      '(So with this whole major thing\, what are your plans after you graduate?))

?a48. (You reply-to.v ?a47.)

?a50. (Me react-to.v ?a48.)

?a51. (Me say-to.v you
      '(And what is your dream job?))

?a52. (You reply-to.v ?a51.)

?a53. (Me react-to.v ?a52.)

?a55. (Me say-to.v you
      '(For me\, my dream job would be as a programmer for some small startup company \. I think it would be especially fun if I could do it with a bunch of friends I already know from college\. I think it would be great if the people you work with are also people you really enjoy spending time with\. But maybe it could be also bad if the only people you hang out with after work are the same guys that you got sick of during the day\. What are your thoughts about work friends?))

?a56. (You reply-to.v ?a55.)

?a57. (Me react-to.v ?a56.)

?a58. (Me say-to.v you
      '(Listen\, I think we need to finish for today\, but it has been great knowing you! Pleas click on the stop botton to end this conversation\.))
?a59. (Me say-to.v you
      '(Bye\.))

)); end of defparameter *lissa-schema*




(setf (get '*lissa-schema* 'semantics) (make-hash-table))
 ; EL formulas (not yet used)

(defun store-output-semantics (var wff schema-name)
;`````````````````````````````````````````````````
; E.g., var = ?a15., wff = (me tell.v you ...)). Store the wff under
; key 'var' in the hash table at (get schema-name 'semantics)
;
 (setf (gethash var (get schema-name 'semantics)) wff)
 ); end of store-output-semantics

(mapcar #'(lambda (x) 
           (store-output-semantics (first x) (second x) '*lissa-schema*))
;``````````````````````````````````````````````````````````````````````
; There seem to be two alternative ways of supplying semantics for
; Lissa's outputs. The first is to assume that our dialog schema
; supplies English outputs directly via quotation, as is currently
; done. The second is to assume that dialog schemas in general
; specify what to do as logical formulas -- which are then rendered
; into verbal output via schemas, world knowledge, and knowledge
; of English (esp. structuring knowledge for output, and surface
; generation). In the latter case, the plan itself already supplies
; the semantics of what is to be said, and which is used as basis
; for generating output. 
;
; Since the current method is the former one, here is an attempt 
; to supply meaning representations for the steps. 
;
; [But even that is rather premature -- for interpreting a user input
; in light of a prior Lissa output, we're currently assuming that the
; "interpretations" of the outputs are just English "gist" clauses,
; plus perhaps additional clauses (as word lists). For example, 
; ?a3 below ends with "how about you?", so a suitable gist clause
; would be (What is your major ?), which is quite adequate for 
; guiding the pattern matching in "interpreting" the user's reply
; (such as "I'm in physics", yielding (I am a physics major)). So
; we also specify ]
;
 '((?a1. ; Hi I am LISSA. I am an autonomous avatar ... etc.
         (me explain-to.v you (ans-to (wh ?x ((we do.v ?x) @ ?e)))))
   (?a2. ; Alright, let's get to know each other more
         (me suggest-to.v you (that ((we (become.v acquainted.a)) @ ?e))))
   (?a3. ; I am a senior comp sci major, how about you?
         ((me tell.v you
           (that 
             ((me (be.v (nn (nn computer.n science.n) major.n))) @ Now)))
          and (me ask.v you 
                  (ans-to (wh ?x ((you (have-as.v major.n) ?x) @ Now))))))
   (?a7. ; What was your favourite class so far?
         (me ask.v you 
            (ans-to (wh ?x ((you have-as.v (favourite.a class.n) ?x) @ Now)))))
   (?a11. ; Did you find it hard?
          (me ask.v you
            (whether (the ?x ((you have-as.v (favourite.a class.n) ?x) @ Now)
                             (you (find.v hard.a) @ (time-of.f ?x))))))
                             ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?a15. ; I liked Artificial Intelligence! that was my favourite by far!
          (me tell.v you
             (that (the ?x (?x (nn AI.n class.n))
                           (((me like.v ?x) @ (time-of.f ?x)) and
                            (me have-as.v 
                              ((by-far.adv favourite.a) class.n) ?x))))))
   ; I'm skipping ahead to questions that may become redundant because
   ; the user may have answered them already.
   (?a24. ; And what do you not like about it?
          (me ask.v you
            (ans-to (wh ?x ((Rochester.name have-as.s property.n ?x) and
                            (you dislike.v 
                              (that (Rochester.name have-as.s property.n
                                                                 ?x))))))))
                    ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?a43. ; have you been to Dinosaur Barbecue?
          (me ask.v you
             (whether (some ?e (?e before Now)
                               ((you (be.v (at-loc.p Dinosaur_Barbecue))) ** ?e)))))
                                ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
 )); end of mapcar #'store-output-semantics


(setf (get '*lissa-schema* 'gist-clauses) (make-hash-table))

(defun store-output-gist-clauses (var clauses schema-name)
;````````````````````````````````````````````````````````
; E.g., var = ?a15., wff = ((My favorite class was AI)). Store 
; the gist clauses under key 'var' in the hash table at 
; (get schema-name 'gist-clauses)
;
 (setf (gethash var (get schema-name 'gist-clauses)) clauses)
 ); end of store-output-gist-clauses
(mapcar #'(lambda (x) 
           (store-output-gist-clauses (first x) (second x) '*lissa-schema*))
;``````````````````````````````````````````````````````````````````````````
; Use of the logical formulas provided via 'store-output-semantics' 
; above is beyond the current methodology.
;
; So here we instead supply information of type
;      (<gist clause1> <gist clause2> <gist clause3> ...)
; where any question gist clause is assumed to come last (as is
; normal in dialogue), and will provide the main context for interpreting
; the next user input.
;
 '((?a1. ; Hello again, its nice to see you. V are going to pick up our conversation
         ((hello again\.) (let us continue our conversation \.)))
   (?a2. ; Have you thought about what city you\'d want to move to next?
         ((what city would you want to move to next ?)))
   (?a7. ; Huh? Why is it special to you?
         ((why is that city special for you ?)))
   (?a11. ; And tell me more about the kind of home you would want live in
          ((What kind of home would you want to live in ?)))
   (?a16. ; So what if money was not an issue and you could live anywhere in the world Where would you go?
          ((where would you live if money was not a concern ?)))
   (?a20. ; And what would your dream home be like?
          ((what would your dream home be like ?)))
   (?a24. ; What do you think your crazy room would be?
          ((what would your crazy room be like ?)))
   (?a28. ; So now I know a little bit about you, I am getting curious, where did you grow up?
          ((where did you grow up ?)))
   (?a32. ; What do you think is the biggest difference between your hometown and living here?
          ((what is the biggest difference between your hometown and Rochester ?)))
   (?a36. ; Tell me\, what do you miss about your hometown?
          ((what do you miss about your hometown ?)))
   (?a40. ; What do you like better here?
          ((what do you like better in Rochester ?)))
   (?a43. ; Do you stay in touch with any of your friends from home?
          ((do you stay in touch with any of your friends from home ?)))
   (?a47. ; So with this whole major thing\, what are your plans after you graduate?
          ((what are your plans after you graduate ?)))
   (?a51. ; And what is your dream job?
          ((what is your dream job ?)))
   (?a55. ; For me\, my dream job would be... What are your thoughts about work friends?
          ((what do you think about work friends ?)))
          
 )); end of mapcar #'store-output-gist-clauses


(setf (get '*lissa-schema* 'topic-keys) (make-hash-table))

(defun store-topic-keys (var keys schema-name)
;``````````````````````````````````````````````
; E.g., var = ?a11., keys = (favorite-class difficulty). 
; Store the list under key 'var' in the hash table at 
;   (get schema-name 'question-topic-keys)
;
 (setf (gethash var (get schema-name 'topic-keys)) keys)
 ); end of store-topic-keys

(mapcar #'(lambda (x) 
           (store-topic-keys (first x) (second x) '*lissa-schema*))
;``````````````````````````````````````````````````````````````````
; The topic keys are currently needed in order to recognize cases 
; where a previous user input with the same topic keys as a question
; about to be asked by Lissa has already been answered (so that
; Lissa should refrain from answering the question).
;
; NOTE: For multiple-sentence outputs by Lissa, if they include a
;       question, the gist version of the question is assumed to
;       always come last. Thus it is unambiguous as to which gist
;       clause falls under the stored topic-keys. (For now, topic
;       keys are stored only for questions, not assertions by Lissa.)
;
 '((?a3. ; Have you thought about what city you\'d want to move to next?
         (city-want-to-move))
   (?a7. ;What is special about that city?
         (special-about-city-want-to-move))
   (?a11. ; And tell me more about the kind of home you would want live in?
          (home-want-to-live-in))
   (?a16. ; So what if money was not an issue and you could live anywhere in the world Where would you go?
          (ideal-place-to-live))
   (?a20. ; And what would your dream home be like?
          (dream-home))
   (?a24. ; What do you think your crazy room would be?
          (crazy-room))
   (?a28. ; So now I know a little bit about you, I am getting curious, where did you grow up?
          (hometown))
   (?a32. ; What do you think is the biggest difference between your hometown and living here?
          (Rochester-hometown-difference))
   (?a36. ; Tell me, what do you miss about your hometown?
          (miss-about-hometown))
   (?a40. ; What do you like better here?
          (like-better-in-Rochester))
   (?a43. ; Do you stay in touch with any of your friends from home?
          (friends-from-home))
   (?a47. ; So with this whole major thing, what are your plans after you graduate?
          (plans-after-graduation))
   (?a51. ; And what is your dream job?
          (dream-job))
   (?a55. ; what do you think about work friends ?
          (work-friends))
 )); end of mapcar
