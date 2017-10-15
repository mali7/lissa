
;; fast start-up: with this file, we can use
;;   (load "start-lissa5.lisp") or (load "start-lissa5")
;;   (lissa t)
;; to get under way
(load *ttt-addr*)
;(load "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")
(load "lissa5"); lissa5.lisp is the main Lissa code
(load "lissa5-schema.lisp"); schematic dialog steps
(load "choose-doolittle-response-1.lisp")  ; rule part of original data.lisp
(load "general-word-data-5.lisp") ; generic word-level stuff from data.lisp
;(load "user-thanks-schema") ; testing only
(load "choose-gist-clause-trees-for-input.lisp")
(load "choose-reactions-to-input.lisp")
(load "choose-reaction-to-input.lisp")
(load "choose-wff-extraction-trees-for-input.lisp")
(load "rules-for-holidays-activities-input")
(load "rules-for-family-gathering-input")
(load "rules-for-holidays-best-part-input")
(load "rules-for-holidays-you-prefer-input")
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