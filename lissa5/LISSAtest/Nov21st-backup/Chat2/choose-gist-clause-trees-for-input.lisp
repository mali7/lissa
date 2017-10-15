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
;;
;; ((what city would you want to move to next ?))
;; ((why is that city special for you ?))
;; ((What kind of home would you want to live in ?))
;; ((where would you live if money was not a concern ?))
;; ((what would your dream home be like ?))
;; ((what would your crazy room be like ?))
;; ((where did you grow up ?))
;; ((what is the biggest difference between your hometown and Rochester ?))
;; ((what do you miss about your hometown ?))
;; ((what do you like better in Rochester ?))
;; ((do you stay in touch with any of your friends from home ?))
;; ((what are your plans after you graduate ?))
;; ((what is your dream job ?))
;; ((what do you think about work friends ?))

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
 '(1 (0 what city 4 move 0) 
    2 (*specific-answer-from-city-want-to-move-input*
       *unbidden-answer-from-city-want-to-move-input*
       *thematic-answer-from-city-want-to-move-input*
       *question-from-city-want-to-move-input*) (0 :subtrees)
   1 (3 why 4 city special 0) 
    2 (*specific-answer-from-special-about-city-input* 
       *unbidden-answer-from-special-about-city-input*
       *thematic-answer-from-special-about-city-input*
       *question-from-special-about-city-input*) (0 :subtrees)
  1 (3 what kind 2 home 3 want 1 live 0) 
    2 (*specific-answer-from-home-want-to-live-input* 
       *unbidden-answer-from-home-want-to-live-input*
       *thematic-answer-from-home-want-to-live-input*
       *question-from-home-want-to-live-input*) (0 :subtrees)
   1 (0 where 2 live 1 money 0)
    2 (*specific-answer-from-ideal-place-to-live-input* 
       *unbidden-answer-from-ideal-place-to-live-input*
       *thematic-answer-from-ideal-place-to-live-input*
       *question-from-ideal-place-to-live-input*) (0 :subtrees)
   1 (2 what 4 dream home 0)
    2 (*specific-answer-from-dream-home-input* 
       *unbidden-answer-from-dream-home-input*
       *thematic-answer-from-dream-home-input*
       *question-from-dream-home-input*) (0 :subtrees)
   1 (2 what 4 crazy room 0) 
    2 (*specific-answer-from-crazy-room-input* 
       *unbidden-answer-from-crazy-room-input*
       *thematic-answer-from-crazy-room-input*
       *question-from-crazy-room-input*) (0 :subtrees)
      ; Note: we need to look for negation first
      ; (at least if we want to allow for some ultimate
      ; flexibility in formulating Lissa's gist clauses
      ; -- perhaps by automatic interpretation/abstraction
      ; from actual outputs)
   1 (2 where 2 grow up 0)
    2 (*specific-answer-from-hometown-input* 
       *unbidden-answer-from-hometown-input*
       *thematic-answer-from-hometown-input*
       *question-from-hometown-input*) (0 :subtrees)
   1 (2 what 2 biggest difference 2 hometown 1 Rochester 0)
    2 (*specific-answer-from-rochester-hometown-difference-input* 
       *unbidden-answer-from-rochester-hometown-difference-input*
       *thematic-answer-from-rochester-hometown-difference-input*
       *question-from-rochester-hometown-difference-input*) (0 :subtrees)
   1 (2 what 2 miss 3 hometown 0)
    2 (*specific-answer-from-miss-about-hometown-input* 
       *unbidden-answer-from-miss-about-hometown-input*
       *thematic-answer-from-miss-about-hometown-input*
       *question-from-miss-about-hometown-input*) (0 :subtrees)
   1 (2 what 3 like better 1 Rochester 0)
    2 (*specific-answer-from-like-better-in-Rochester-input* 
       *unbidden-answer-from-like-better-in-Rochester-input*
       *thematic-answer-from-like-better-in-Rochester-input*
       *question-from-like-better-in-Rochester-input*) (0 :subtrees)
   1 (3 Do you stay 1 touch 4 friends 1 home 0)
    2 (*specific-answer-from-friends-from-home-input* 
       *unbidden-answer-from-friends-from-home-input*
       *thematic-answer-from-friends-from-home-input*
       *question-from-friends-from-home-input*) (0 :subtrees)
   1 (2 what 2 plans after 1 graduate 0)
    2 (*specific-answer-from-plans-after-graduation-input* 
       *unbidden-answer-from-plans-after-graduation-input*
       *thematic-answer-from-plans-after-graduation-input*
       *question-from-plans-after-graduation-input*) (0 :subtrees)
   1 (2 what 2 dream job 0)
    2 (*specific-answer-from-dream-job-input*
	   *unbidden-answer-from-dream-job-input*
	   *thematic-answer-from-dream-job-input*
	   *question-from-dream-job-input*) (0 :subtrees)
   1 (2 what 2 think 1 work friends 0)
    2 (*specific-answer-from-work-friends-input*
	   *unbidden-answer-from-work-friends-input*
	   *thematic-answer-from-work-friends-input*
	   *question-from-work-friends-input*) (0 :subtrees)
   )))
