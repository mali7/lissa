;; "choose-reactions-to-input.lisp"  (note the plural!)
;; =======================================================
;; File for choosing a schema for a potentially compound reaction
;; to a feature-augmented gist "passage" -- multiple gist clauses
;; separated by stand-alone periods or question marks (& ending
;; in a period or question mark). (The packet for single clauses
;; is "choose-reaction-to-input.lisp" -- note the singular.) The
;; result returned is of form
;;    (<schema name> <list of selected gist clauses>),
;; where the selected gist clauses are intended as arguments of
;; the schema (exclusive of the event variable). Thus in further
;; elaboration of a schema, the implementation of individual
;; steps can be made dependent on the gist clause each step is
;; intended to react to.
;;
;; The idea is that any schema(s) we supply here will be elaborated
;; in the planning process so as to check at least any initial
;; non-question gist clauses for possible reactions, using 
;; '*reaction-to-input*' to pick specific choice trees and using
;; the latter to obtain a non-nil result if possible. For question
;; gist clauses at or near the end, the elaboration process will
;; use '*reaction-to-question*', which should lead to more specific
;; choice trees for answering (or deflecting) the question.
;;
;; **We might ultimately allow for more than one schema (plus
;; arguments) as the value reurned, so that Lissa can exhibit some
;; variety in the way multiple-clause contributions by the user
;; are handled. We could either supply lists of schemas (with
;; args), leaving the choice to the planner, or begin with small,
;; high-level choice trees that choose among schemas for compound
;; reactions by Lissa (allowing for latency to avoid repetitiveness).

(eval-when (load eval)

(READRULES '*reactions-to-input*
  ; Very rough initial attempt; the rules should be carefully
  ; designed to reflect patterns of input gist clauses responding 
  ; to Lissa's questions, extracted by *specific-answer-from-...*, 
  ; *thematic-answer-from-...*, and *question-from-...* choice
  ; trees specified in the various "rules-for-...lisp" files for
  ; specific inputs.
  ;
  ; Note that we cannot expect to directly provide sensible reactions
  ; to user inputs such as "Yeah", or "I haven't really decided yet".
  ; We're assuming instead that such inputs have been made explicit
  ; in the process of gist clause extraction. Consider for example
  ; reciprocal questions or other questions such as "What about you?"
  ; or "What have you had?" -- we depend on the gist clause extraction
  ; trees, such as those in *question-from-like-about-rochester-input*
  ; or *question-from-garbage-plate-input*, to produce gist clauses
  ; such as "What do you like about Rochester ?" or "Have you had a
  ; garbage plate ?". 
  ;
  ; So the decomposition patterns here assume that we have a sequence
  ; of gist clause assertions and questions in which assertions are
  ; followed by stand-alone "\." and questions by stand-alone "?".
  ; All we look for is the arrangement and lengths of the constituent
  ; clauses in the choice of a response schema. We also need to
  ; identify the individual clauses to be responded to, since these
  ; will be needed as schema arguments.
  ;
  ; Deal with input containing questions first.
 '(1 (0 ? 0); is there a question?
    2 (0 \. 0 ?); >= 1 answer clause, and final question;
                ; react to initial clause & final question --
                ; we need to identify the end of the answer
                ; clause and the start of final question.
                ; Note: most gist clauses are short, and we
                ;       intend to keep them to <= 10 words.
                ;       Unfortunately the lack of local negation
                ;       in the pattern syntax makes the following
                ;       quite awkward. (TTT will make it easier.)
     3 (0 \. 0 end-punc 0 ?); answer, intervening clauses, & question
      4 (5 \. 0 end-punc 5 ?); short answer & question?
       5 (*reaction-to-question* (5 ?))  ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause);(0 :schema+args)
      4 (5 \. 0 end-punc 10 ?); allow longer question 
       5 (*reaction-to-question* (5 ?))  ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause);(0 :schema+args)
      4 (10 \. 0 end-punc 5 ?); allow longer answer clause
       5 (*reaction-to-question* (5 ?)) ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
      4 (10 \. 0 end-punc 10 ?); allow longer answer clause & question
       5 (*reaction-to-question* (5 ?)) ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
     3 (10 \. 10 ?); no intervening clauses (by above level-3 failure)
      4 (*reaction-to-question* (3 ?)) ;(*reactions-to-answer+question* ((1 \.) (3 ?)))
        (0 :subtree+clause) ;(0 :schema+args)
    2 (0 ? 6); non-final question (by previous level-2 failure);
             ; is it close to the end? If so, respond to it;
     3 (0 \. 0 end-punc 0 ? 6); initial clause, & intervening one(s)?
      4 (5 \. 0 end-punc 5 ? 6); short answer & question?
       5 (*reaction-to-question* (5 ?)) ; (*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
      4 (5 \. 0 end-punc 10 ? 6); allow longer question
       5 (*reaction-to-question* (5 ?)) ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
      4 (10 \. 0 end-punc 5 ? 6); allow longer answer clause
       5 (*reaction-to-question* (5 ?)) ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
      4 (10 \. 0 end-punc 10 ? 6); allow longer answer clause & question
       5 (*reaction-to-question* (5 ?)) ;(*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
     3 (10 \. 10 ? 6); no intervening clauses (by above level-3 failure)
      4 (*reaction-to-question* (3 ?)) ;(*reactions-to-answer+question* ((1 \.) (3 ?)))
        (0 :subtree+clause) ;(0 :schema+args)
    2 (0 ?); only one question has been detected
     3 (*reaction-to-question* (1 ?)) ; (*reactions-to-answer+question* ((1 \.) (5 ?)))
         (0 :subtree+clause) ;(0 :schema+args)
   ; No question among the gist clauses (by earlier level-1 failure)
   1 (5 \. 0); short initial answer? Respond just to that
    2 (*reaction-to-assertion* (1 \.))
      (0 :subtree+clause)
   1 (10 \. 0); longer initial answer? Respond just to that
    2 (*reaction-to-assertion* (1 \.))
      (0 :subtree+clause)
 )); end of *reactions-to-input*

); end of eval-when
