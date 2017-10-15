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
;;	What do you remember about your first car ?
;;	Have you ever taken a fun road trip ?
;;	How one can cope with giving up driving ?
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
 '(1 (2 what 1 you remember 2 first car 3)
    2 (*specific-answer-from-first-car-input* 
       *unbidden-answer-from-first-car-input*
       *thematic-answer-from-first-car-input*
       *question-from-first-car-input*) (0 :subtrees)
   1 (1 have you 4 road trip 4) 
    2 (*specific-answer-from-road-trips-input* 
       *unbidden-answer-from-road-trips-input*
       *thematic-answer-from-road-trips-input*
       *question-from-road-trips-input*) (0 :subtrees)
   1 (1 how 2 cope 1 giving up driving 3)
    2 (*specific-answer-from-giving-up-driving-input* 
       *unbidden-answer-from-giving-up-driving-input*
       *thematic-answer-from-giving-up-driving-input*
       *question-from-giving-up-driving-input*) (0 :subtrees)
)))
