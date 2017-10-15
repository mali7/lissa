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
;;   ((what is your major ?) (I am a computer science major))
;;   ((what was your favorite class ?))
;;   ((did you find your favorite class hard ?))
;;   ((my favorite class was AI))
;;   ((How long have you been in Rochester ?))
;;   ((What do you like about Rochester ?))
;;   ((What do you not like about Rochester ?))
;;   ((What would you change in Rochester ?))
;;   ((What would we do on a tour of Rochester ?))
;;   ((What is your favorite restaurant in Rochester ?))
;;   ((What kind of food is a garbage plate ?))
;;   ((have you been to the Dinosaur Barbecue ?))
;;   ((Do you like watching TV and movies\, or reading books ?))
;;   etc. (others to be added)
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
 '(1 (3 what 4 your major 0) 
    2 (*specific-answer-from-major-input* 
       *unbidden-answer-from-major-input*
       *thematic-answer-from-major-input*
       *question-from-major-input*) (0 :subtrees)
   1 (3 what 4 your favorite class 0) 
    2 (*specific-answer-from-favorite-class-input* 
       *unbidden-answer-from-favorite-class-input*
       *thematic-answer-from-favorite-class-input*
       *question-from-favorite-class-input*) (0 :subtrees)
   1 (0 your favorite class hard 0)
    2 (*specific-answer-from-hardness-of-class-input* 
       *unbidden-answer-from-hardness-of-class-input*
       *thematic-answer-from-hardness-of-class-input*
       *question-from-hardness-of-class-input*) (0 :subtrees)
   1 (2 how long 6 in Rochester 0)
    2 (*specific-answer-from-how-long-in-rochester-input* 
       *unbidden-answer-from-how-long-in-rochester-input*
       *thematic-answer-from-how-long-in-rochester-input*
       *question-from-how-long-in-rochester-input*) (0 :subtrees)
   1 (6 you not 2 like 4 Rochester 1) 
    2 (*specific-answer-from-not-like-about-rochester-input* 
       *unbidden-answer-from-not-like-about-rochester-input*
       *thematic-answer-from-not-like-about-rochester-input*
       *question-from-not-like-about-rochester-input*) (0 :subtrees)
      ; Note: we need to look for negation first
      ; (at least if we want to allow for some ultimate
      ; flexibility in formulating Lissa's gist clauses
      ; -- perhaps by automatic interpretation/abstraction
      ; from actual outputs)
   1 (6 not you 2 like 4 Rochester 1)
     ; e.g., What DON'T you like about Rochester?
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
   1 (2 what 3 we 1 do 4 tour of Rochester 0)
    2 (*specific-answer-from-tour-of-rochester-input* 
       *unbidden-answer-from-tour-of-rochester-input*
       *thematic-answer-from-tour-of-rochester-input*
       *question-from-tour-of-rochester-input*) (0 :subtrees)
   1 (2 what 2 your favorite restaurant 4 in Rochester 0)
    2 (*specific-answer-from-favorite-eatery-in-rochester-input* 
       *unbidden-answer-from-favorite-eatery-in-rochester-input*
       *thematic-answer-from-favorite-eatery-in-rochester-input*
       *question-from-eatery-in-rochester-input*) (0 :subtrees)
   1 (2 what 2 your favorite place 3 eat 3 in Rochester 0)
    2 (*specific-answer-from-favorite-eatery-in-rochester-input* 
       *unbidden-answer-from-favorite-eatery-in-rochester-input*
       *thematic-answer-from-favorite-eatery-in-rochester-input*
       *question-from-favorite-eatery-in-rochester-input*) (0 :subtrees)
   1 (2 what 4 is a garbage plate 0)
    2 (*specific-answer-from-garbage-plate-input* 
       *unbidden-answer-from-garbage-plate-input*
       *thematic-answer-from-garbage-plate-input*
       *question-from-garbage-plate-input*) (0 :subtrees)
   1 (3 you 5 Dinosaur Barbecue 0)
    2 (*specific-answer-from-dinosaur-bbq-input* 
       *unbidden-answer-from-dinosaur-bbq-input*
       *thematic-answer-from-dinosaur-bbq-input*
       *question-from-dinosaur-bbq-input*) (0 :subtrees)
   1 (3 you 1 like watching 5 or 5 reading 0)
    2 (*specific-answer-from-watching-or-reading-input* 
       *unbidden-answer-from-watching-or-reading-input*
       *thematic-answer-from-watching-or-reading-input*
       *question-from-watching-or-reading-input*) (0 :subtrees)
   1 (2 what type of movies 4 you 0)
    2 (*specific-answer-from-movie-genre-input*
	   *unbidden-answer-from-movie-genre-input*
	   *thematic-answer-from-movie-genre-input*
	   *question-from-movie-genre-input*) (0 :subtrees)
   1 (0 favorite movie 0)
    2 (*specific-answer-from-favorite-movie-input*
	   *unbidden-answer-from-favorite-movie-input*
	   *thematic-answer-from-favorite-movie-input*
	   *question-from-favorite-movie-input*) (0 :subtrees)
   1 (2 you 1 seen 2 star wars 0)
    2 (*specific-answer-from-seen-star-wars-input*
	   *unbidden-answer-from-seen-star-wars-input*
	   *thematic-answer-from-seen-star-wars-input*
	   *question-from-seen-star-wars-input*) (0 :subtrees)
   1 (3 you 1 prefer 5 theater or 5 Netflix 0)
    2 (*specific-answer-from-theater-or-netflix-input*
	   *unbidden-answer-from-theater-or-netflix-input*
	   *thematic-answer-from-theater-or-netflix-input*
	   *question-from-theater-or-netflix-input*) (0 :subtrees)
   )))
