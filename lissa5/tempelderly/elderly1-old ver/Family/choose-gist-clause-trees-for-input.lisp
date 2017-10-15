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
;;   (What do you do for holidays ?)
;;   (What is the best part of holidays ?)
;;   (Are there other holidays you prefer ?)
;;   (Have you been to any weddings recently ?)
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
   1 (3 what 2 you 3 holidays 0)
    2 (*specific-answer-from-holidays-activities-input* 
       *unbidden-answer-from-holidays-activities-input*
       *thematic-answer-from-holidays-activities-input*
       *question-from-holidays-activities-input*) (0 :subtrees)
   1 (3 what 2 best part 0)
    2 (*specific-answer-from-holidays-best-part-input* 
       *unbidden-answer-from-holidays-best-part-input*
       *thematic-answer-from-holidays-best-part-input*
       *question-from-holidays-best-part-input*) (0 :subtrees)
   1 (3 are there 2 holidays you prefer 0)
    2 (*specific-answer-from-holidays-you-prefer-input* 
       *unbidden-answer-from-holidays-you-prefer-input*
       *thematic-answer-from-holidays-you-prefer-input*
       *question-from-holidays-you-prefer-input*) (0 :subtrees)
   1 (3 have you 2 family gathering 1 recently 0)
    2 (*specific-answer-from-family-gathering-input* 
       *unbidden-answer-from-family-gathering-input*
       *thematic-answer-from-family-gathering-input*
       *question-from-family-gathering-input*) (0 :subtrees)
   )))
