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
;;	What are your best qualities ?
;;  What are things you want to change about yourself ?
;;  What are your hopes and wishes ?

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
 '(1 (2 what 1 your best qualities 1)
    2 (*specific-answer-from-what-had-for-breakfast-input* 
       *unbidden-answer-from-what-had-for-breakfast-input*
       *thematic-answer-from-what-had-for-breakfast-input*
       *question-from-what-had-for-breakfast-input*) (0 :subtrees)
   1 (1 what 2 things 3 change about yourself 1) 
    2 (*specific-answer-from-favorite-icecream-flavor-input* 
       *unbidden-answer-from-favorite-icecream-flavor-input*
       *thematic-answer-from-favorite-icecream-flavor-input*
       *question-from-favorite-icecream-flavor-input*) (0 :subtrees)
   1 (1 what 2 hopes and wishes 1)
    2 (*specific-answer-from-favorite-food-input* 
       *unbidden-answer-from-favorite-food-input*
       *thematic-answer-from-favorite-food-input*
       *question-from-favorite-food-input*) (0 :subtrees)
)))
