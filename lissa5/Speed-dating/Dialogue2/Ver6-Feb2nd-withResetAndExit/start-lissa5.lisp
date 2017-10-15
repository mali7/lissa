
;; fast start-up: with this file, we can use
;;   (load "start-lissa5.lisp") or (load "start-lissa5")
;;   (lissa t)
;; to get under way

;(load "/p/nl/tools/ttt/src/load.lisp")
(load "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")
(load "lissa5"); lissa5.lisp is the main Lissa code
(load "lissa5-schema.lisp"); schematic dialog steps
;(load "structify.lisp"); define script structure & mapping "free-form" script
;                       ; into a script structure. Postponed for now!
(load "choose-doolittle-response-1.lisp")  ; rule part of original data.lisp
(load "general-word-data-5.lisp") ; generic word-level stuff from data.lisp
; (load "user-thanks-schema") ; testing only
(load "choose-gist-clause-trees-for-input.lisp")
(load "choose-reactions-to-input.lisp")
(load "choose-reaction-to-input.lisp")
;(load "choose-specific-wff-answer-from-favorite-class-input.lisp")
(load "choose-wff-extraction-trees-for-input.lisp")
(load "rules-for-city-want-to-move-input.lisp")
(load "rules-for-special-about-city-want-to-move-input.lisp")
(load "rules-for-home-want-to-live-input.lisp")
(load "rules-for-ideal-place-to-live-input.lisp")
(load "rules-for-dream-home-input.lisp")
(load "rules-for-crazy-room-input.lisp")
(load "rules-for-hometown-input.lisp")
(load "rules-for-rochester-hometown-difference-input.lisp")
(load "rules-for-miss-about-hometown-input.lisp")
(load "rules-for-like-better-in-Rochester-input.lisp")
(load "rules-for-friends-from-home-input.lisp")
(load "rules-for-plans-after-graduation-input.lisp")
(load "rules-for-dream-job-input.lisp")
(load "rules-for-work-friends-input.lisp")
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
        
;(lissa t) ; disable for the moment (for debuggin)

(defun mainLoop ()
(let (c)
(setq c 1)
(while (eq c 1)       	
    (progn 
	(lissa t)
	(setq endInput (hear-words))
	(format t "~% this is the input ~a ~%" endInput)
    (while (or (not endInput) (and (not (eq (car endInput) 'restart)) (not (eq (car endInput) 'exit))))  
           (setq endInput (hear-words)))
    (if (eq (car endInput) 'restart) (setq c 1) (setq c 0)))) 
))

(mainLoop)