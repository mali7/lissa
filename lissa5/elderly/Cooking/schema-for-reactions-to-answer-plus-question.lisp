
;; Aug, 21/15: define the schema *reactions-to-answer+question*
;; ================================================================
;; 
;; This is intended to "work" for one or more non-question gist 
;; clauses followed by a final gist-clause question.
;;
;; The idea is to react to the question first, followed by "so" 
;; (as a new-topic-initiation signal), followed by a reaction to
;; the initial gist clause. (So this schema ignores any intermediate
;; clauses.) 
;;
;; An alternative would be to react to the initial gist clause
;; first, followed by "As for your question," or something similar;
;; in general, it seems to require stronger discourse signals to
;; get back to an unanswered question than to get back to another
;; component of the user's input. Also, this would work well for 
;; question-deflection responses by Lissa like "Let's keep the 
;; focus on you". Anyway, in future, we might provide multiple
;; applicable schemas in "choose-reactions-to-input.lisp", and
;; choose from these (via a small choice tree, even if only to
;; vary response styles by using non-zero latency?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *reactions-to-answer+question*

'(Event-schema ((me react-to-answer+question ?answer ?question) ** ?e)
;`````````````````````````````````````````````````````````````````````
; LISSA reacts to one or more answer gist clauses plus a question
; gist clause from the user (in response to a LISSA question).
;
; The schema simply combines a reaction to the question and a reaction
; to the answer based on appropriate choice trees, joining them
; with discourse connective "so". To be able to process individual
; (Me react-to.v ...) components in the usual way, we "hallucinate"
; separate user inputs of form
;    (You paraphrase.v '...)
; containing single user gist clauses, viewing these as what the
; use had in mind but "paraphrased" in the context of the preceding
; Lissa question.

:actions ; we start execution at this keyword
         ; (other schema components are omitted for the time being.)
?a1. (You paraphrase.v '?question)

?a2. (Me react-to.v ?a1.)

?a3. (Me say-to.v you '(So \,))

?a4. (You paraphrase.v '?answer)

?a5. (Me react-to.v ?a4.)

)); end of parameter *reactions-to-answer+question*


(setf (get '*reactions-to-answer+question* 'semantics) 
      (make-hash-table))
 ; To fill this in, EL formulas would need to be derived from
 ; Lissa reactions (not yet used). This would be rather unlike
 ; the explicit 'store-output-semantics' used in *lissa-schema*
 ; (see "lissa5-schema.lisp").


(setf (get '*reactions-to-answer+question* 'gist-clauses) 
      (make-hash-table))
 ; Much the same comment as above applies -- something other than
 ; the straightforward 'store-output-gist-clauses' used in
 ; the *lissa-schema* code would be needed.

