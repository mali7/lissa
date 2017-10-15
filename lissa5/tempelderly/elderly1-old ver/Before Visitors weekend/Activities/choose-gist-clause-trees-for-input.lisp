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
;;   (what are your hobbies ?)
;;   (do you like to read ?)
;;   (what kind of things you like to read ?)
;;   (how do you spend your days ?)
;;   (what kind of things do you like in your neighborhood ?)
 

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
 '(1 (3 what are 1 hobbies 0) 
    2 (*specific-answer-from-hobbies-input* 
       *unbidden-answer-from-hobbies-input*
       *thematic-answer-from-hobbies-input*
       *question-from-hobbies-input*) (0 :subtrees)
   1 (3 do 1 like to read 0) 
    2 (*specific-answer-from-like-to-read-input* 
       *unbidden-answer-from-like-to-read-input*
       *thematic-answer-from-like-to-read-input*
       *question-from-like-to-read-input*) (0 :subtrees)
   1 (3 what 2 things you like to read 0)
    2 (*specific-answer-from-things-like-to-read-input* 
       *unbidden-answer-from-things-like-to-read-input*
       *thematic-answer-from-things-like-to-read-input*
       *question-from-things-like-to-read-input*) (0 :subtrees)
   1 (3 how 2 you spend 1 days 0)
    2 (*specific-answer-from-spend-your-days-input* 
       *unbidden-answer-from-spend-your-days-input*
       *thematic-answer-from-spend-your-days-input*
       *question-from-spend-your-days-input*) (0 :subtrees)
   1 (3 what 4 you like 4 neighborhood 0)
    2 (*specific-answer-from-things-in-neighborhood-input* 
       *unbidden-answer-from-things-in-neighborhood-input*
       *thematic-answer-from-things-in-neighborhood-input*
       *question-from-things-in-neighborhood-input*) (0 :subtrees)
   )))
