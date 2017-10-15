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
;;	How is the weather outside ?
;;  How is the weather forecast for this evening ?
;;  What is your favorite weather ?

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
 '(1 (2 how 2 weather 3)
    2 (*specific-answer-from-how-is-weather-input* 
       *unbidden-answer-from-how-is-weather-input*
       *thematic-answer-from-how-is-weather-input*
       *question-from-how-is-weather-input*) (0 :subtrees)
   1 (1 how 3 weather forecast 4) 
    2 (*specific-answer-from-weather-forecast-input* 
       *unbidden-answer-from-weather-forecast-input*
       *thematic-answer-from-weather-forecast-input*
       *question-from-weather-forecast-input*) (0 :subtrees)
   1 (1 what 2 favorite weather 3)
    2 (*specific-answer-from-favorite-weather-input* 
       *unbidden-answer-from-favorite-weather-input*
       *thematic-answer-from-favorite-weather-input*
       *question-from-favorite-weather-input*) (0 :subtrees)
)))
