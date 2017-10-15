
;; fast start-up: with this file, we can use
;;   (load "start-lissa5.lisp") or (load "start-lissa5")
;;   (lissa t)
;; to get under way

(load *ttt-addr*)
;(load "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")
(load "lissa5"); lissa5.lisp is the main Lissa code
(load "lissa5-schema"); schematic dialog steps
(load "choose-doolittle-response-1.lisp")  ; rule part of original data.lisp
(load "general-word-data-5.lisp") ; generic word-level stuff from data.lisp
(load "choose-gist-clause-trees-for-input.lisp")
(load "choose-reactions-to-input.lisp")
(load "choose-reaction-to-input.lisp")
(load "choose-wff-extraction-trees-for-input.lisp")
(load "rules-for-tour-of-rochester-input.lisp")
(load "rules-for-favorite-eatery-in-rochester-input")   
(load "rules-for-garbage-plate-input.lisp")
(load "rules-for-dinosaur-bbq-input.lisp")
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
        


; activate one of the following code lines:
(lissa *mode*) ; for one round
;(mainLoop)  ; for repeated round