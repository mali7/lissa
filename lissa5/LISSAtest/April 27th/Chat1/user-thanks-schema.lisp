(defparameter *user-thanks-schema*

'(Event-schema (((set of me you) have-lissa-dialog.v) ** ?e)

:Actions ; we start execution at this keyword
         ; (I've omitted other schema components for the time being.)
         ; Lissa's lengthy initial utterance may eventually be broken into
         ; a few higher-level (nonprimitive) actions such as introducing
         ; herself, the purpose and structure of the dialog, and the 
         ; explanation of the icons, with each nonprimitive action broken 
         ; down in turn into a number of (primitive) saying-acts.
?a1. (Me say-to.v you 
      '(Hi I am LISSA.; I am an autonomous avatar and my behaviour is driven 
       ;by artificial intelligence.
       ;I may sound choppy\, but I am still able to have a conversation with you.
       ;I am here to help you practice talking about yourself\, so we will have 
       ;   a conversation focused on you. 
       ;This will be more helpful\, if you give longer answers.
       ;During the conversation\, the system will try its best to prompt you 
       ;   on your eye contact\, volume\, body movements\, and smiling.
       ;If the eye icon flashes red\, it means you can try making more eye contact.
       ;If the smiley face flashes red\, perhaps you could try smiling more.
       ;If the speaker icon flashes red\, then pay attention to your voice. 
       ;You might need to speak up or you might need to quiet down.
       ;If the shaking person icon flashes red\, then pay attention to your body. 
       ;Can you be more animated? Is your posture okay?
       ;As you make these adjustments\, the icon will switch back to green.
     ))

?a2. (Me say-to.v you
      '(Alright\, let\'s get to know each other more\.))
?a3. (Me say-to.v you
      '(I am a senior comp\'s eye major\, how about you?))

?a4. (You reply-to.v ?a3.)   ; This is a nonprimitive action by the user, to be

?a5. (Me react-to.v ?a4.); react to the "gist" of the user's input

?a7. (Me say-to.v you '(What was your favourite class so far?))

?a8. (You reply-to ?a7.) ; again leads to a (READWORDS) call, and 
                         ; formation of a subordinate 
                         ; (you say-to.v me '(...)) plan
?a10. (Me react-to.v ?a8.)

?a11. (Me say-to.v you '(Did you find it hard?))

?a12. (You reply-to.v ?a11.) ; again leads to a (READWORDS) call, and
                             ; formation of a subordinate
                             ; (you say-to.v me '(...)) plan

?a14. (Me react-to.v ?a12.)

?a15. (Me say-to.v you     
      '(I liked Artificial Intelligence! that was my favourite by far!))
?a16. (Me say-to.v you
      '(Though obviously\, I am a little bit biased on the subject\. I really 
        think the material is great and the prof is even better\.))

?a17. (Me say-to.v you '(So how long have you been in Rochester?))

?a18. (You reply-to.v ?a17.)

?a20. (Me react-to.v ?a18.)

?a21. (Me say-to.v you
      '(What do you like most about Rochester?))

?a22. (You reply-to.v ?a21.)

?a23. (Me react-to.v ?a22.)

?a24. (Me say-to.v you
      '(And what do you not like about it?))

?a25. (You reply-to.v ?a24.)

?a27. (Me react-to.v ?a25.)

?a28. (Me say-to.v you
      '(Is there anything you would change?))

?a29. (You reply-to.v ?a28.)

?a31. (Me react-to.v ?a29.)

?a32. (Me say-to.v you
      '(If you can\'t tell\, I haven\'t seen much of the city at 
        all\. What would we do if you took me on a tour?))

?a33. (You reply-to.v ?a32.)

?a35. (Me react-to.v ?a33.)

?a36. (Me say-to.v you
      '(One thing I always wonder about are good places to eat\. You might not think it by looking at me\, but I think restaurants are just great\. I love to watch people enjoy their food\. I also love the way that every place has its own unique atmosphere\. It doesn\'t have to be fancy\. I also love those dirty spoon\, hole in the wall restaurants that have a really fun and cool vibe\. Could you tell me about your favorite place to eat here in Rochester?))

?a37. (You reply-to.v ?a36.)

?a39. (Me react-to.v ?a37.)

?a40. (Me say-to.v you
      '(And what\'s this whole garbage plate thing about?))

?a41. (You reply-to.v ?a40.)

?a42. (Me react-to.v ?a41.) ; no choice tree here yet & perhaps inappropriate,
                            ; in view of the next Lissa output
?a43. (Me say-to.v you
      '(That sounds interesting\. I\'m actually curious to try it\. 
        By the way\, have you been to Dinosaur Barbecue?))

?a44. (You reply-to.v ?a43.)

?a46. (Me react-to.v ?a44.)

?a47. (Me say-to.v you
      '(Tell me about your free time\. Do you like watching TV and 
        movies\, or are you more of a book reader?))

?a48. (You reply-to.v ?a47.)

?a50. (Me react-to.v ?a48.)

?a51. (Me say-to.v you
      '(What type of movies do you like ?))

?a52. (You reply-to.v ?a51.)

?a53. (Me react-to.v ?a52.)

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
 '((?a1. ; Hi I am LISSA. I am an autonomous avatar ... etc.
         ((hello \.) (I am an avatar \.) (I am driven by AI \.)))
   (?a2. ; Alright, let's get to know each other more
         ((let us get to know each other \.)))
         ; the above gist clauses are not really needed at present
   (?a3. ; I am a senior comp sci major, how about you?
         ((I am a computer science major \.) (what is your major ?)))
   (?a7. ; What was your favourite class so far?
         ((what was your favorite class ?)))
   (?a11. ; Did you find it hard?
          ((did you find your favorite class hard ?)))
           ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?a15. ; I liked Artificial Intelligence! that was my favourite by far!
          ((my favorite class was AI \.)))
   ; I'm skipping ahead to questions where a gist is needed
   (?a17. ; So how long have you been in Rochester?
          ((How long have you been in Rochester ?)))
   (?a21. ; What do you like most about Rochester?
          ((What do you like about Rochester ?)))
   (?a24. ; And what do you not like about it?
          ((What do you not like about Rochester ?)))
          ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?a28. ; Is there anything you would change?
          ((What would you change in Rochester ?)))
   (?a32. ; If you can\'t tell\, I haven\'t seen much of the city 
          ; at all\. What would we do if you took me on a tour?
          ((What would we do on a tour of Rochester ?)))
   (?a36. ; One thing I always wonder about ... Could you tell me 
          ; about your favorite place to eat here in Rochester?
          ((What is your favorite restaurant in Rochester ?)))
   (?a40. ; And what\'s this whole garbage plate thing about?
          ((What kind of food is a garbage plate ?)))
   (?a43. ; That sounds interesting\. I\'m actually curious to try 
          ; it\. By the way\, have you been to Dinosaur Barbecue?
          ((have you been to Dinosaur Barbecue ?)))
          ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?a47. ; Tell me about your free time\. Do you like watching TV 
          ; and movies\, or are you more of a book reader?
          ((Do you like watching TV and movies \, or reading books ?)))
   (?a51. ; What type of movies do you like?
          ((What type of movies do you like ?)))
   (?a54. ; Do you have a favorite movie?
          ((Do you have a favorite movie ?)))
   (?a57. ; Have you seen the new star wars film?
          ((Have you seen the new star wars film ?)))
   (?a60. ; So do you prefer going to the movie theater, or watching Netflix?
          ((Do you prefer going to the movie theater\, or watching Netflix ?)))
	  
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
 '((?a3. ; I am a senior comp sci major, how about you?
         (study-major))
   (?a7. ; What was your favourite class so far?
         (favorite-class))
   (?a11. ; Did you find it hard?
          (favorite-class difficulty))
   (?a17. ; So how long have you been in Rochester?
          (Rochester-residency))
   (?a21. ; What do you like most about Rochester?
          (like-rochester))
   (?a24. ; And what do you not like about it?
          (not-like-rochester))
   (?a28. ; Is there anything you would change?
          (Rochester-enhancements))
   (?a32. ; If you can\'t tell\, I haven\'t seen much of the city 
          ; at all\. What would we do if you took me on a tour?
          (Rochester-tour))
   (?a36. ; One thing I always wonder about ... Could you tell me 
          ; about your favorite place to eat here in Rochester?
          (Rochester-eateries))
   (?a40. ; And what\'s this whole garbage plate thing about?
          (garbage-plate))
   (?a43. ; That sounds interesting\. I\'m actually curious to try 
          ; it\. By the way\, have you been to Dinosaur Barbecue?
          (Dinosaur-visit))
   (?a47. ; Tell me about your free time\. Do you like watching TV 
          ; and movies\, or are you more of a book reader?
          (watching-versus-reading))
   (?a52. ; What type of movies do you like?
          (movie-genre))
 )); end of mapcar
