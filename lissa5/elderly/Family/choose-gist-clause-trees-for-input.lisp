;; File for setting up the choice tree *gist-clause-trees*,
;; which selects among specific gist-clause extraction trees
;; for processing a user input, based on a feature-augmented 
;; initial gist clause for Lissa's output (usually a question
;; to the user that prompted the input).
;;
;; The following Lissa gist clauses are from "lissa5-schema.lisp",
;; where 'store-output-gist-clauses' is used to store output
;; gist clauses in a hash table indexed by action proposition
;; variables, and the hash table itself is accessed as property
;; 'gist-clauses' of *lissa-schema*:
;;
;;   (Do you live by yourself or with others ?)
;;   (How long have you lived there ?)
;;   (Do you have children or grandchildren ?) 
;;   (Do you use facebook or skype ?)
;;
;;   While these are hand-supplied, the idea is that ultimately
;;   they would be set up automatically via NLP. For example,
;;   "Did you find it hard?" might readily lead to gist clause
;;   "Did you find your favorite class hard?" if we can successfully
;;   resolve the anaphor. More subtly, a trailing question "What
;;   about you?" often seems interpretable as a kind of analogical
;;   variant of the speaker's preceding assertion, just changing
;;   a nominal (etc.) phrase -- e.g., "I'm a comp sci major"  --> 
;;   "I'm a ... major"; "My favorite movie is Bladerunner"  --> 
;;   "My favorite movie is ...", etc.
;;
;;   This is why we don't simply use a verbatim match to Lissa's
;;   output.

(eval-when (load eval)

(READRULES '*gist-clause-trees-for-input*
 '(1 (3 do you live 2 yourself 0) 
    2 (*specific-answer-from-live-alone-input* 
       *unbidden-answer-from-live-alone-input*
       *thematic-answer-from-live-alone-input*
       *question-from-live-alone-input*) (0 :subtrees)
   1 (3 how long 1 you lived 0) 
    2 (*specific-answer-from-how-long-lived-there-input* 
       *unbidden-answer-from-how-long-lived-there-input*
       *thematic-answer-from-how-long-lived-there-input*
       *question-from-how-long-lived-there-input*) (0 :subtrees)
   1 (3 do you have children 0)
    2 (*specific-answer-from-children-input* 
       *unbidden-answer-from-children-input*
       *thematic-answer-from-children-input*
       *question-from-children-input*) (0 :subtrees)
   1 (3 do you 1 facebook 0)
    2 (*specific-answer-from-use-facebook-input* 
       *unbidden-answer-from-use-facebook-input*
       *thematic-answer-from-use-facebook-input*
       *question-from-use-facebook-input*) (0 :subtrees)
   
   )))
