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
;;   ((what did you have for breakfast ?))
;;   ((what is your favorite flavor of ice cream ?))
;;   ((what is your favorite food ?))
;;   ((How did you get here today ?))
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
 '(1 (3 where are you from 0) 
    2 (*specific-answer-from-hometown-input* 
       *unbidden-answer-from-hometown-input*
       *thematic-answer-from-hometown-input*
       *question-from-hometown-input*) (0 :subtrees)
   1 (3 tell me more 4 hometown 0) 
    2 (*specific-answer-from-describe-hometown-input* 
       *unbidden-answer-from-describe-hometown-input*
       *thematic-answer-from-describe-hometown-input*
       *question-from-describe-hometown-input*) (0 :subtrees)
   1 (3 how 2 like the weather 2 hometown 0)
    2 (*specific-answer-from-hometown-weather-input* 
       *unbidden-answer-from-hometown-weather-input*
       *thematic-answer-from-hometown-weather-input*
       *question-from-hometown-weather-input*) (0 :subtrees)
   1 (3 how 2 end up in Rochester 0)
    2 (*specific-answer-from-endup-in-rochester-input* 
       *unbidden-answer-from-endup-in-rochester-input*
       *thematic-answer-from-endup-in-rochester-input*
       *question-from-endup-in-rochester-input*) (0 :subtrees)
   )))
