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
      '(If you can\'t tell\, I haven\'t seen much of the city at 
        all\. What would we do if you took me on a tour?))

?a2. (You reply-to.v ?a1.)

?a4. (Me react-to.v ?a2.)

?a5. (Me say-to.v you
      '(One thing I always wonder about are good places to eat\. You might not think it by looking at me\, but I think restaurants are just great\. I love to watch people enjoy their food\. I also love the way that every place has its own unique atmosphere\. It doesn\'t have to be fancy\. I also love those dirty spoon\, hole in the wall restaurants that have a really fun and cool vibe\. Could you tell me about your favorite place to eat here in Rochester?))

?a6. (You reply-to.v ?a5.)

?a8. (Me react-to.v ?a6.)

?a9. (Me say-to.v you
      '(And what\'s this whole garbage plate thing about?))

?a10. (You reply-to.v ?a9.)

?a12. (Me react-to.v ?a10.) ; no choice tree here yet & perhaps inappropriate,
                            ; in view of the next Lissa output
?a13. (Me say-to.v you
      ;That sounds interesting\. I\'m actually curious to try it\. 
      '(By the way\, have you been to Dinosaur Barbecue?))

?a14. (You reply-to.v ?a13.)

?a16. (Me react-to.v ?a14.)

?a17. (Me say-to.v you
      '(Lets pause here so I can give you feedback\.))
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
 '((?a1. ; If you can\'t tell\, I haven\'t seen much of the city 
          ; at all\. What would we do if you took me on a tour?
          ((What would we do on a tour of Rochester ?)))
   (?a5. ; One thing I always wonder about ... Could you tell me 
          ; about your favorite place to eat here in Rochester?
          ((What is your favorite restaurant in Rochester ?)))
   (?a9. ; And what\'s this whole garbage plate thing about?
          ((What kind of food is a garbage plate ?)))
   (?a13. ; That sounds interesting\. I\'m actually curious to try 
          ; it\. By the way\, have you been to Dinosaur Barbecue?
          ((have you been to the Dinosaur Barbecue ?)))   
   (?a17. ; Let\’s pause here so I can give you feedback.
          ((lets pause for a feedback \.)))
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
 '((?a1. ; If you can\'t tell\, I haven\'t seen much of the city 
          ; at all\. What would we do if you took me on a tour?
          (Rochester-tour))
   (?a5. ; One thing I always wonder about ... Could you tell me 
          ; about your favorite place to eat here in Rochester?
          (Rochester-eateries))
   (?a9. ; And what\'s this whole garbage plate thing about?
          (garbage-plate))
   (?a13. ; That sounds interesting\. I\'m actually curious to try 
          ; it\. By the way\, have you been to Dinosaur Barbecue?
          (Dinosaur-visit))
   	  )); end of mapcar
