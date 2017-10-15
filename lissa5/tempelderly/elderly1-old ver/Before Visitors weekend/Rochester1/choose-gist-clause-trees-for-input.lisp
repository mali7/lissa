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
 '(1 (2 how long 6 in Rochester 0)
    2 (*specific-answer-from-how-long-in-rochester-input* 
       *unbidden-answer-from-how-long-in-rochester-input*
       *thematic-answer-from-how-long-in-rochester-input*
       *question-from-how-long-in-rochester-input*) (0 :subtrees)
   1 (6 you not 2 like 4 Rochester 1) 
    2 (*specific-answer-from-not-like-about-rochester-input* 
       *unbidden-answer-from-not-like-about-rochester-input*
       *thematic-answer-from-not-like-about-rochester-input*
       *question-from-not-like-about-rochester-input*) (0 :subtrees)
   1 (2 what 2 you like 4 Rochester 0)
    2 (*specific-answer-from-like-about-rochester-input* 
       *unbidden-answer-from-like-about-rochester-input*
       *thematic-answer-from-like-about-rochester-input*
       *question-from-like-about-rochester-input*) (0 :subtrees)
   1 (2 what 2 you 2 change 4 Rochester 0)
    2 (*specific-answer-from-changing-rochester-input* 
       *unbidden-answer-from-changing-rochester-input*
       *thematic-answer-from-changing-rochester-input*
       *question-from-changing-rochester-input*) (0 :subtrees)
)))
