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
;;	How long have you been in Rochester
;;	What do you like most about Rochester?
;;	And what do you not like about it?
;;	Is there anything you would change?
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
 '(1 (2 what 3 we 1 do 4 tour of Rochester 0)
    2 (*specific-answer-from-tour-of-rochester-input* 
       *unbidden-answer-from-tour-of-rochester-input*
       *thematic-answer-from-tour-of-rochester-input*
       *question-from-tour-of-rochester-input*) (0 :subtrees)
   1 (2 what 2 your favorite restaurant 4 in Rochester 0)
    2 (*specific-answer-from-favorite-eatery-input* 
       *unbidden-answer-from-favorite-eatery-input*
       *thematic-answer-from-favorite-eatery-input*
       *question-from-favorite-eatery-input*) (0 :subtrees)
   1 (2 what 3 is 2 garbage plate 0)
    2 (*specific-answer-from-garbage-plate-input* 
       *unbidden-answer-from-garbage-plate-input*
       *thematic-answer-from-garbage-plate-input*
       *question-from-garbage-plate-input*) (0 :subtrees)
   1 (3 you 5 Dinosaur Barbecue 0)
    2 (*specific-answer-from-dinosaur-bbq-input* 
       *unbidden-answer-from-dinosaur-bbq-input*
       *thematic-answer-from-dinosaur-bbq-input*
       *question-from-dinosaur-bbq-input*) (0 :subtrees)

)))
