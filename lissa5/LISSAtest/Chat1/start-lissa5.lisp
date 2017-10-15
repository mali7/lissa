
;; fast start-up: with this file, we can use
;;   (load "start-lissa5.lisp") or (load "start-lissa5")
;;   (lissa t)
;; to get under way

(load "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")
(load "lissa5"); lissa5.lisp is the main Lissa code
(load "lissa5-schema.lisp"); schematic dialog steps
(load "choose-doolittle-response-1.lisp")  ; rule part of original data.lisp
(load "general-word-data-5.lisp") ; generic word-level stuff from data.lisp
(load "user-thanks-schema") ; testing only
(load "choose-gist-clause-trees-for-input.lisp")
(load "choose-reactions-to-input.lisp")
(load "choose-reaction-to-input.lisp")
;(load "choose-specific-wff-answer-from-favorite-class-input.lisp")
(load "choose-wff-extraction-trees-for-input.lisp")
(load "rules-for-major-input.lisp")
(load "rules-for-favorite-class-input.lisp")
(load "rules-for-hardness-of-class-input.lisp")
(load "rules-for-how-long-in-rochester-input.lisp")
(load "rules-for-like-about-rochester-input.lisp")
(load "rules-for-not-like-about-rochester-input.lisp")
(load "rules-for-changing-rochester-input.lisp")
(load "rules-for-tour-of-rochester-input.lisp")
(load "rules-for-favorite-eatery-in-rochester-input")   
(load "rules-for-garbage-plate-input.lisp")
(load "rules-for-dinosaur-bbq-input.lisp")
(load "rules-for-watching-or-reading-input.lisp")
(load "rules-for-movie-genre-input.lisp")
(load "rules-for-favorite-movie-input.lisp")
(load "rules-for-seen-star-wars-input.lisp")
(load "rules-for-theater-or-netflix-input.lisp")
(load "schema-for-reactions-to-answer-plus-question.lisp")
(load "schema-for-reactions-to-question+clause.lisp")

(format t "~%~%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ~
             ~% TO RUN LISSA IN PRINT-MODE OR TALK-MODE, USE RESPECTIVE CALLS
             ~%           (lissa nil)    (lissa t)
             ~%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ~
             ~% ALSO NOTE: For inhibiting repetitive outputs via latency, do ~
             ~%            (setq *use-latency* T) ~
             ~% THOUGH THAT'S NOT RECOMMENED IN THE LISSA DEVELOPMENT PHASE
             ~%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        

(defun mainLoop ()
(let (c)
(setq c 1)
(while (eq c 1)       	
    (progn 
	(lissa t)
	(setq endInput (hear-words))
	(format t "~% this is the input ~a ~%" endInput)
    (while (or (not endInput) (and (not (member endInput 'restart)) (not  (member endInput 'exit))))  
           (setq endInput (hear-words)))
    (if (eq (car endInput) 'restart) 
	    (setq c 1) (setq c 0))	
	)
) 
))

; activate one of the following code lines:
(lissa nil) ; for one round
;(mainLoop)  ; for repeated round