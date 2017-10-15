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
;;	What kinds of dishes do you like to cook ?
;;	How did you learn to cook ?
;;	How have you shared cooking with people in your life ? 
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
 '(1 (2 what 2 dishes 2 like to cook 3)
    2 (*specific-answer-from-dishes-like-to-cook-input* 
       *unbidden-answer-from-dishes-like-to-cook-input*
       *thematic-answer-from-dishes-like-to-cook-input*
       *question-from-dishes-like-to-cook-input*) (0 :subtrees)
   1 (1 how 2 learn to cook 4) 
    2 (*specific-answer-from-learn-to-cook-input* 
       *unbidden-answer-from-learn-to-cook-input*
       *thematic-answer-from-learn-to-cook-input*
       *question-from-learn-to-cook-input*) (0 :subtrees)
   1 (1 how 2 shared cooking 1 people 3)
    2 (*specific-answer-from-share-cooking-with-others-input* 
       *unbidden-answer-from-share-cooking-with-others-input*
       *thematic-answer-from-share-cooking-with-others-input*
       *question-from-share-cooking-with-others-input*) (0 :subtrees)
)))
