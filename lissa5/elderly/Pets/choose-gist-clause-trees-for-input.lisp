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
;;	Do you have a pet at home?
;;  Tell me about a pet of a family member or neighbor
;;  How do pets help their owners?

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
 '(1 (2 do 1 have 1 pet 3)
    2 (*specific-answer-from-have-a-pet-input* 
       *unbidden-answer-from-have-a-pet-input*
       *thematic-answer-from-have-a-pet-input*
       *question-from-have-a-pet-input*) (0 :subtrees)
   1 (1 Tell me about 2 pet 3 family 2 neighbor 3) 
    2 (*specific-answer-from-family-neighbor-pet-input* 
       *unbidden-answer-from-family-neighbor-pet-input*
       *thematic-answer-from-family-neighbor-pet-input*
       *question-from-family-neighbor-pet-input*) (0 :subtrees)
   1 (1 how 2 pets help 3)
    2 (*specific-answer-from-pets-help-owners-input* 
       *unbidden-answer-from-pets-help-owners-input*
       *thematic-answer-from-pets-help-owners-input*
       *question-from-pets-help-owners-input*) (0 :subtrees)
)))
