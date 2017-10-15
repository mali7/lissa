;; July 31/15: Modify LISSA4 to associate "gist clauses" and
;; (for later use) interpretations with user inputs and Lissa 
;; outputs. [UNDER CONSTRUCTION]
;;
;; For inputs, we use the question it answers to create a list
;; of simple, explicit English clauses, especially the first of 
;; which is intended to capture the "gist" of what was said,
;; i.e., the content of an utterance most likely to be needed
;; to understand the next turn in the dialogue. The intent is that
;; logical interpretations will later play that role, and this
;; has been initiated by supplying a hash table of (some) Lissa 
;; output interpretations,
;;     *output-semantics*
;; (which uses keys such as (*lissa-schema* ?a3.) along with the
;; hash table of gist clauses,
;;     *output-gist-clauses*
;; (indexed in the same way). These tables can be used to set up
;; the 'interpretation' and 'output-gist-clauses' properties of
;; action proposition names, generated in forming plans from 
;; schemas.
;;
;; One important goal in setting up these tables is to be able
;; later to match certain user inputs to Lissa question gists/
;; interpretations, to see if the inputs already answer the
;; questions, making them redundant. 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; -*- Common-Lisp -*-

 ; [This is partly derivative from "doolittle", an improvement of
 ; Weizenbaum's ELIZA that carries information forward from the
 ; previous question/answer pair, makes greater use of features,
 ; uses more flexible, hierarchical pattern matching, and initially
 ; classifies inputs by their general form (instead of by keyword).]
	
 ; To run the program, do the following (while in the present
 ; lissa directory):
 ; lisp
 ; (load "start-lissa5")
 
(defvar *use-latency* nil); Use response inhibition via latency numbers only
                          ; when *use-latency* = T

(defvar *dialog-plan*); this is initialized from a dialog schema, and
                      ; is (destructively) modified as the plan is
                      ; implemented; it retains already completed actions,
                      ; but the 'rest-of-plan' property tells us where 
                      ; we are in the plan currently (the "now" point)
                      ; Action names can have a 'subplan' property,
                      ; pointing to the name of a subplan that in turn
                      ; has a 'rest-of-plan' property, etc.
;(defvar *context*) ; a doolittle relic, kept here because we'll probably
;                   ; want to have some sort of *context* parameter
;                   ; eventually, e.g., for the identity of the inter-
;                   ; locutors, potential referents, etc. The doolittle
;                   ; *context* was reset when doolittle asked a question,
;                   ; and any very brief user response (such as "yes",
;                   ; or "my mother") was expanded using that context.
;(defvar *memory*) ; another doolittle relic: a list of saved responses,
;                  ; to be used to revert to an earlier exchange, if 
;                  ; no better options remained. This idea may still be
;                  ; relevant to Lissa.
(defvar *count* 0); number of Lissa outputs generated so far (maintained
                  ; for latency enforcement, i.e., not repeating a previously
                  ; used response too soon).

(defvar *gist-kb* (make-hash-table :test #'equal)); for storage of gist
                ; clauses, particularly ones obtained from user inputs;
(clrhash *gist-kb*)
(defparameter *live* nil); *live* = T indicates "live usage", i.e.,
                ; with the avatar; *live* = nil is for terminal use.

; NOTE: Instead of doolittle's "contexts", Lissa has USE-CHOICE-TREE
; and USE-SCHEMA "directives" in its reassembly rules, giving the name
; of another choice tree or schema to be used to construct a step or 
; steps for a subplan.
;
; AS A MEMORY-PEG: The final doolittle code also allowed special "theme"
; atoms in "contexts" (as specified in reassembly rules) that enabled
; repetitive return to the same "region" of the doolittle choice tree,
; maintaining topical focus. This may also turn out to be relevant to
; Lissa, although currently we attempt to maintain topical consistency
; in Lissa by (a) following sequences of steps, and (b) computing "gist
; clauses" or interpretations based on the user input, which should reveal
; the current theme unambiguously, and thus enable making relevant
; response choices.
;
(defvar *tracerules* NIL); can be set to T to activate rule-tracing

(defvar *lissa-count*); ** I'm no sure why this new var is used in addition
                      ;    to *count*, which also counts Lissa outputs-LKS
(setq *lissa-count* 0)

; Other global parameters used here, but whose values are set elsewhere,
; are:  ***THIS NEEDS UPDATING
;      *next-input*
;      *output-semantics*
;      *output-gist-clauses*
;      *lissa-schema* (top-level schema) & possibly many subschemas
;      *reactions-to-input* (top-level choice tree for selecting a
;         schema or subtree to react to a user turn (possibly multiple
;         extracted "gist clauses")
;      *reaction-to-assertion* for individual user assertions
;      *reaction-to-question* for individual user questions
;      *interpretation-of-input* (top-level interpretation tree),
;         and many other interpretation trees (built from packets).
;      *gist-clause-trees* (top-level gist clause extraction
;         tree) and many subsidiary gist-clause extraction trees
;         (formed from corresponding packets).
;
; A NOTE ON "PACKET/TREE" TERMINOLOGY: We generally refer to the contents
;      of files like "choose-reaction-to-assertion.lisp", "choose-reaction-
;      to-major5.lisp", "find-interpretation-of-input.lisp", "form-gist-
;      clauses-from-input.lisp", etc., as choice packets, interpretation
;      packets, and gist-clause packets; but the decision/transduction
;      trees formed from these packets, like *reaction-to-assertion*,
;      *reaction-to-major*, ..., *gist-clause-trees*, etc., are
;      referred to as (choice/ interpretation/ gist-clause) trees.

(with-open-file (outfile "./output.txt" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))

(defun lissa (live); Sep 2/15: live = t: avatar mode; live = nil: terminal
 ;;              ; We set global variable *live* = live, for use elsewhere
 ;; Main program: Originally handled initial and final formalities,
 ;; (now largely commented out) and controls the loop for producing,
 ;; managing, and executing the dialog plan (mostly, reading & feature-
 ;; annotating inputs & producing outputs, but with some subplan
 ;; formation, gist clause formation, etc.).
 ;;
  (prog (; INPUT L NAME 
        )
        (setq *live* live)
        ; Though the initial name-inquiry is not used in Lissa, let's
        ; keep it around because it involves iteration -- something
        ; currently not allowed for in the schema/plan action syntax,
        ; but eventually should be (along with conditional branching)!
	;(format t "~%... HELLO, I AM LISSA.")
	;(format t "~%... WHAT'S YOUR NAME?~%")
   ;NAME (SETQ INPUT (READ-WORDS))
	;(SETQ L (LENGTH INPUT))
	;(COND ((OR (= L 0) (> L 3)) ; no name or too many?
	;       (format t "~%... WHAT'S YOUR FIRST NAME, PLEASE?~%")
	;       (GO NAME) ))
	;(SETQ NAME (CAR INPUT))
	;(format t "~%... HI, ~a.~%" NAME)
	;(SETQ *MEMORY* (LIST (CONC1 '(I GUESS WE'RE DONE\,)
	;                             (LIST NAME '?) ) '(NIL) ))
	;(SETQ *MEMORY* '()) ; updated for lissa -- but actually not used

	(setq *count* 0)            ; number of outputs so far	
                                    ; (in doolittle, it was #inputs))

        ; We now create a partially instantiated dialog plan from a 
        ; schema. 'Initialize-plan' starts with a copy of the desired 
        ; schema, replaces the variable for the first action proposition 
        ; by a new name, and sets the 'rest-of-plan' property of 
        ; *dialog-plan* to point to the rest of the plan, beginning 
        ; with the new name. Some other connections are set up as well 
        ; via properties of atoms. 
        ; (** We might later use structures instead of properties; see 
        ; "structify.lisp".)
        (initialize-plan '*dialog-plan* '*lissa-schema* nil); args = nil
        ;(print-current-plan-status '*dialog-plan*); DEBUGGING
        
        ; Next we call 'process-next-action' repeatedly, always
        ; continuing with the action at the 'rest-of-plan' pointer.
        ; After completion of an action, the 'rest-of-plan' pointer is
        ; advanced, and the new schema action variable it is pointing 
        ; to is replaced (using 'update-plan') by a new action name.
        ; This action may actually be nonprimitive and as such may have
        ; a 'subplan' property pointing to a named subplan that also
        ; has a 'rest-of-plan' property, indicating what remains to 
        ; be done in the subplan, etc. If the most immediate subaction
        ; is primitive (immediately executable, e.g., (me say-to.v you
        ; '(...))), execute it, and advance the 'rest-of-plan' pointer
        ; of the named plan containing that primitive action. Otherwise
        ; form and initialize a subplan (perhaps just one step, esp.
        ; a say-step) that expands it, and set the 'rest-of-plan'
        ; pointer of the subplan to the first action (i.e., the entire
        ; subplan). 
        ;    In reacting to user inputs, Lissa will use doolittle-like
        ; generic choice packets as a last resort for unmatchable or
        ; offensive, complimentary, etc., user inputs. But all reactions,
        ; based on a degree of understanding or not, will be formulated
        ; as subplans whose step or steps are primitive actions like
        ; (Me say-to.v you '...).
        (format t "~%")
nextact (process-next-action '*dialog-plan*); execute; or form a subplan
        ; 
        ; The execution should also increase *count* for each Lissa
        ; utterance (needed for output latency enforcement); ultimately
        ; this could also be used for switching to alternative main-script
        ; utterances, to give a user some variety.
        ;
        ; After the previous processing step, update the 'rest-of-plan'
        ; pointers; e.g., if we've just executed the last step of a
        ; subplan, the pointer of the parent plan should be advanced
        ; one step, and 'update-plan' should be applied so as to
        ; initialize the next step.
        ;(print-current-plan-status '*dialog-plan*); DEBUGGING
        ;(format t "~% here is after the print-current-plan-status -----------")
        (update-rest-of-plan-pointers '*dialog-plan*)
        ;(format t "~% here is after the update-rest-of-plan-pointers -----------")
        ;(print-current-plan-status '*dialog-plan*); DEBUGGING
        ;(format t "~% here is after the print-current-plan-status -----------")
        ;       (format t "~%'rest-of-plan' pointers have been updated"); DEBUGGING
        (when (not (null (get '*dialog-plan* 'rest-of-plan)))
              ; We might insert some plan-checking and amendment steps here,
              ; if for example a subplan for some step has been initialized
              ; or partially executed, and this might have affected the
              ; consistency or expected effects/benefits of the plan.
              (go nextact))

        (format t "~% ... THANK YOU FOR VISITING,~%") 
        (format t "GOOD-BYE FOR NOW")
        (return '------------------------------------ )
)) ; end of lissa


;; Note: An alternative to the following pointer-update function
;; would be to use the "upward" connections from subplans to steps
;; (via the plan name's 'subplan-of' pointer) whenever a primitive
;; action has been executed. This would require that all steps
;; of the main *dialog-plan* also have a 'subplan-of' property
;; that supplies '*dialog-plan*' as value. That's because if we 
;; want to update the 'rest-of-plan' pointer of a plan, we need
;; the plan name.
;;
(defun update-rest-of-plan-pointers (plan-name); Aug 1/15
;``````````````````````````````````````````````
; This gets a plan & its subplans ready for processing the next
; step by updating 'rest-of-plan' pointers and making sure that
; for any completed step (at any level) the next step of the schema
; being progressively instantiated has been initialized (given a
; unique (dualized) step name, with a 'gist-clause' property, etc.) 
; via 'update-plan'.
;
; If the rest-of-plan' pointer of 'plan-name' is nil, no pointer
; updates are needed (the plan of 'plan-name' is fully executed).
;    If the first step at the 'rest-of-plan' pointer of 'plan-name'
; has no 'subplan' property, then no updates are needed -- the most
; recent step executed was a primitive one, so that the 'rest-of-plan'
; pointer was aleady updated and the next step was initialized (via
; 'update-plan').
;
; Otherwise, after recursively updating the 'rest-of-plan' pointers
; of the subplan (whose name is accessed via the first action's
; 'subplan' property), if the pointer for that action has become nil,
; advance the 'rest-of-plan' pointer of 'plan-name' by one step;
; (the currently due step of 'plan-name' has been fully executed);
; then initialize its next action (if any) using 'update-plan'.
;
 (let ((rest (get plan-name 'rest-of-plan)) step-name subplan-name)
      (setq step-name (car rest))
;     (format t "~%~%'rest-of-plan' pointer of ~a at beginning of update~
;                ~% is (~a ~a ...)" plan-name step-name (second rest)); DEBUGGING
      (cond ((null rest) nil)
            ((or (not (symbolp step-name)); unexpected
                 (null step-name)) nil); unexpected
            ((null (get step-name 'subplan)) nil)
            (T (setq subplan-name (get step-name 'subplan))
               (when (null (get subplan-name 'rest-of-plan))
;                    (format t "~%~%Since subplan ~a has a NIL 'rest-of-plan',~
;                               ~% advance 'rest-of-plan' of ~a over step ~a~
;                               ~% with WFF = ~a~%" subplan-name plan-name 
;                                step-name (second rest)); DEBUGGING
                     (setf (get plan-name 'rest-of-plan)
                           (cddr1 rest)); step past the name and wff
                                       ; of the now-completed step
                     (update-plan plan-name))))
;     (format t "~%~%'rest-of-plan' pointer of ~a at end of update~
;                ~% is (~a ~a ...)~%" plan-name (car (cddr1 rest))
;                                   (second (cddr1 rest))); DEBUGGING

 )); end of update-rest-of-plan-pointers

(defun cddr1 (x) (cddr x)); for DEBUGGING
            

(defun print-current-plan-status (plan-name); Sep 13/15 (new version)
;```````````````````````````````````````````
; Show plan names, action names and wffs reached in following 
; 'rest-of-plan' pointers from 'plan-name'; also show 'subplan-of'
; pointers. This function is intended for debugging.
;
 (prog ((rest (get plan-name 'rest-of-plan)) step-name wff superstep-name
        subplan-name)
       (format t "~%Status of ~a " plan-name)
       (setq superstep-name (get plan-name 'subplan-of))
       (if superstep-name
           (format t "(subplan-of ~a):" superstep-name)
           (format t "(no superstep):" plan-name))
  next (setq step-name (car rest))
       (when (null step-name)
             (format t "~%  No more steps in ~a." plan-name)
             (format t "~%  --------------------")
             (return-from print-current-plan-status nil))
       (setq wff (second rest))
       (format t "~%  rest of ~a = (~a ~a ...)" plan-name step-name wff)
       (setq subplan-name (get step-name 'subplan))
       (when subplan-name
             (format t "~%  subplan ~a of ~a:" subplan-name step-name)
             (setq rest (get subplan-name 'rest-of-plan))
             (setq plan-name subplan-name)
             (go next))
 )); end of print-current-plan-status
      

(defun modify-response (resp); June 26/15
;```````````````````````````
; A set of word-level operations, formerly part of the main (doolittle)
; program, to prepare choice-packet-derived responses for proper output
  (compress ; AUX not --> AUXn't; 
      (dual 
         (presubst ; changes YOU ARE to YOU ARE2 in preparation
                   ; for replacement of YOU ARE2 by I AM (whereas
                   ; ARE remains ARE); and similarly for some other words
              resp)))
 ); end of modify-response


(defun initialize-plan (plan-name schema-name args); Revised July 31/15
;````````````````````````````````````````````````` ; & Aug 25-28/15
; (eval plan-name) is presumably nil, while (eval schema-name)
; is the schema (starting with '(event-schema ((...) ** ?e))')
; that the plan will be based on. For non-nil 'args', we replace
; successive variables occurring in the (...) part of the header
; (i.e., exclusive of ?e) by successive elements of 'args'.
 (let (plan action-list prop-var prop-name 2names ep-var ep-name
       gist-clauses interpretation topic-keys)
  (setf (get plan-name 'schema-name) schema-name); "remember" the 
                                           ; schema this is based on
; (format t "~%'schema-name' of ~a has been set to ~a" plan-name
;                            (get plan-name 'schema-name)); DEBUGGING
  (set plan-name (copy-tree (eval schema-name)))
                 ;^^^^^^^^^ make full copy, because we want to make
                 ;          destructive changes to the plan
  (setq plan (eval plan-name)); this still has a schema header
  ;;(format t "~%Schema to be used to initialize plan ~a is ~% ~a" 
    ;;        plan-name plan); DEBUGGING
  (setq plan (cons 'plan (cdr plan))); replace 'event-schema' by 'plan'
  (when (not (find :actions plan))
        (format t "~%*** Attempt to form plan ~a from schema ~a ~
                  which contains no ':ACTIONS' keyword" 
                  plan-name schema-name)
        (return-from initialize-plan nil) )
  
  ; Substitute the arguments 'args' (if non-nil) for the variables
  ; in the plan (schema) header (other than an episode variable)
  ; throughout the plan. (The substitution is destructive)
  (if args (setq plan (nsubst-schema-args args plan)))
;;  (format t "~%Schema to be used for plan ~a, with arguments instantiated~
 ;;            ~% ~a" plan-name plan); DEBUGGING

  ; Find first action variable
  (setq action-list (member :actions plan))
                    ; should be a list like (:actions ?a1. ...)
  ;;(format t "~%Action list of argument-instantiated schema is~
   ;;          ~% ~a" action-list); DEBUGGING
  (setq prop-var (second action-list))
  ;(format t "~%The first action variable, ~a, has (variable? ~a) = ~a"
  ;            prop-var prop-var (variable? prop-var)); DEBUGGING
  (when (not (variable? prop-var)); should start with '?'
        (format t "~%*** Attempt to form plan ~a from schema ~a ~
                  which contains no actions" plan-name schema-name)
        (return-from initialize-plan nil) )

  ; Found the next action to be processed; set rest-of-plan pointer
  (setf (get plan-name 'rest-of-plan) 
        (cdr action-list)); begins with prop-var

  ; 'prop-var' should end in a period. An apparent action name 
  ; *including the final period*, e.g., ?a1., actually stands
  ; for the (reified) proposition that the formula so-named 
  ; characterizes the episode whose name is obtained by dropping
  ; the period (e.g., ?a1). Correspondingly we create two new names,
  ; one for the episode, and--by adding a final period--one for the 
  ; reified proposition. E.g., from '?a1.' we might derive the
  ; episode name 'E05' and the proposition name 'E05.'.
  (setq 2names (episode-and-proposition-name prop-var))
  ; e.g., ((?a3 . E35) (?a3. . E35.))

  ; We now substitute the names for the variables (destructively)
  ; in the rest of the plan
  (setq ep-var (caar 2names) ep-name (cdar 2names))
  (nsubst ep-name ep-var (get plan-name 'rest-of-plan))
  (setq prop-var (car (second 2names)))
  (setq prop-name (cdr (second 2names))); though the function
                      ; 'episode-and-proposition-name' can return
                      ; just an episode name if an episode variable
                      ; rather than proposition variable is given
                      ; to it, variable names for plan actions
                      ; should be proposition variables (ending in
                      ; a period)
  (nsubst prop-name prop-var (get plan-name 'rest-of-plan))
  ;;(format t "~%Action list after substituting ~a for ~a: ~% ~a"
   ;;         prop-name prop-var (get plan-name 'rest-of-plan)); DEBUGGING
  ; Also we need to make action formulas available from the
  ; propositions names:
  (setf (get prop-name 'wff) 
        (second (get plan-name 'rest-of-plan)))
  ; If this is a Lissa action, supply the gist clauses, interpretation,
  ; and topic key list from the hash tables associated with 'schema-name':
  (when (eq 'me (car (get prop-name 'wff)))
        ; (no harm done if any of the schema properties are nil)
        (setq gist-clauses 
              (gethash prop-var (get schema-name 'gist-clauses)))
        (setf (get prop-name 'gist-clauses) gist-clauses)
        ;(format t "~%Gist clauses attached to ~a =~% ~a" prop-name
        ;                       (get prop-name 'gist-clauses)); DEBUGGING
        (setq interpretation
              (gethash prop-var (get schema-name 'semantics)))
        (setf (get prop-name 'semantics) interpretation)
        (setq topic-keys
              (gethash prop-var (get schema-name 'topic-keys)))
        (setf (get prop-name 'topic-keys) topic-keys)
        ;(format t "~%Topic keys attached to ~a =~% ~a" prop-name
        ;                       (get prop-name 'topic-keys)); DEBUGGING
   )

  ; The parameter named by plan-name should now have the desired
  ; initial form, i.e., with a new name (instead of a variable) 
  ; for the next action (really, proposition) and the corresponding
  ; event, and we have a pointer 'rest-of-plan' into the plan (as
  ; a property of the name of the plan), whose first element is
  ; the new action name.
 )); end of initialize-plan       
          

(defun variable? (atm) ; starts with "?"; June 18/15
;`````````````````````
  (and (symbolp atm) (char-equal #\? (car (explode atm)))))


(defun nsubst-schema-args (args schema); Aug 28/15
;`````````````````````````````````````
; substitute the successive arguments in the 'args' list for successive
; variables occurring in the schema or plan header exclusive of the 
; episode variable characterized by the header predication (for 
; episodic headers). In relational schemas, headers are assumed to 
; be simple (infix) predications,
;          (<term> <pred> <term> ... <term>),
; and for event schemas they are of form
;          ((<term> <pred> <term> ... <term>) ** <term>).
; We look for variables among the terms (exclusive of the one following
; "**" in the latter header type), and replace them in succession by
; the members of 'args'.
;
 (let (header predication vars)
      (setq header (second schema)); (skip past 'event-schema' or 'plan')
      (if (eq (second header) '**)
          (setq predication (first header)); episodic
          (setq predication header)); nonepisodic
      (if (atom predication); unexpected
          (return-from nsubst-schema-args schema))
      (dolist (x predication)
          (if (variable? x) (push x vars)))
      (when (null vars); unexpected
            (format t "~%@@@ Warning: Attempt to substitute values ~
                       ~%    ~a~%    in header ~a, which has no variables"
                       args predication)
            (return-from nsubst-schema-args schema))
      (setq vars (reverse vars))
      (cond ((> (length args) (length vars))
             (format t "~%@@@ Warning: More values supplied, viz., ~
                        ~%    ~a,~%    than header ~a has variables"
                        args predication)
             (setq args (butlast args (- (length args) (length vars)))))
            ((< (length args) (length vars))
             (format t "~%@@@ Warning: Fewer values supplied, viz., ~
                        ~%    ~a,~%    than header ~a has variables"
                        args predication)
             (setq vars (butlast vars (- (length vars) (length args))))))
            
      ; length of 'args' and 'vars' are equal (or have just been equalized)
      (dotimes (i (length args))
               (nsubst (pop args) (pop vars) schema))
           ; note (destructive) substitution throughout the schema or plan
      schema
 )); end of nsubst-schema-args
      

(defun update-plan (plan-name); as in initialize-plan, substitute
;`````````````````````````````  dual constants for variables
 (let (prop-var 2names ep-var ep-name prop-name schema-name 
       gist-clauses interpretation topic-keys)
; (format t "~% NEXT ACTION AND WFF IN PLAN ~a BEING UPDATED ARE ~a ~
;            ~%  AND ~a" plan-name (car (get plan-name 'rest-of-plan))
;                            (second (get plan-name 'rest-of-plan))); DEBUGGING
  (setq prop-var (car (get plan-name 'rest-of-plan)))
  (when (not (variable? prop-var)); should start with '?'
;       (format t "~%@@ end of plan ~a reached" plan-name) ; DEBUGGING
        (return-from update-plan nil) )

  ; There is a further action to be processed; create the dual 
  ; names (for the episode and the proposition) from the variable:
  (setq 2names (episode-and-proposition-name prop-var))
  ; e.g., ((?a3 . E35) (?a3. . E35.))
  (setq ep-var (caar 2names) ep-name (cdar 2names))
  ; We now substitute the names for the variables (destructively)
  ; in the rest of the plan
  (nsubst ep-name ep-var (get plan-name 'rest-of-plan))
  ; As in initialize-plan, there should also be a prop-var & prop-name
  (setq prop-var (car (second 2names)))
  (setq prop-name (cdr (second 2names)))
  (nsubst prop-name prop-var (get plan-name 'rest-of-plan)) 
  ; Set the 'wff' property of prop-name to the action wff:
  (setf (get prop-name 'wff) 
        (second (get plan-name 'rest-of-plan)))
  ; If this is a Lissa action, supply the gist clauses and
  ; interpretation from the hash tables associated with 'schema-name':
  (setq schema-name (get plan-name 'schema-name))
  (when (eq 'me (car (get prop-name 'wff)))
        (setq gist-clauses 
              (gethash prop-var (get schema-name 'gist-clauses)))
		(setf (get prop-name 'gist-clauses) gist-clauses)
        (setq interpretation
              (gethash prop-var (get schema-name 'semantics)))
        (setf (get prop-name 'semantics) interpretation)
        (setq topic-keys
              (gethash prop-var (get schema-name 'topic-keys)))
        (setf (get prop-name 'topic-keys) topic-keys))

  (get plan-name 'rest-of-plan)
  ; return non-nil value since we found another action to be processed
 )); end of update-plan


(defun episode-and-proposition-name (dual-var); June 18/15
;`````````````````````````````````````````````
; 'dual-var' is normally a variable symbol starting with '?' and ending
; in '.'. As such, it actually stands for 2 variables: a reified-
; proposition variable (when the period is included) and implicitly,
; for an episode variable (when the period is dropped). E.g., '?a1.'
; is a (reified) proposition variable, but implicitly it also specifies
; an episode variable '?a1' (no period). Correspondingly, we create 
; two new names (constants): one for an episode (e.g., 'EP38'), and 
; one for the corresponding reified proposition (e.g., 'EP38.'); we 
; then return the two variables with the two new names, e.g.,
;   ((?a1 . EP38) (?a1. EP38.))
; If there is no final period, we just return an episode name for the
; variable, e.g. if dual-var is just '?a1', we return
;   ((?a1 . EP38))
 (let ((chars (explode dual-var)) ep-var ep-name prop-name result)
      (when (not (char-equal #\? (car chars)))
            (format t "~%***Attempt to form episode and proposition ~
                 name from~%   non-question-mark variable ~a" dual-var)
            (return-from episode-and-proposition-name nil))
      (setq ep-var dual-var); will be used if there's no final period
      (setq ep-name (gensym "EP"))
      (when (char-equal #\. (car (last chars))); form proposition name
            (setq ep-var (implode (butlast chars))) ; implicit ep-var
            (setq prop-name (implode (append (explode ep-name) '(#\.))))
            (setq result (list (cons dual-var prop-name))) )
      (push (cons ep-var ep-name) result)
 )); end of episode-and-proposition-name
                       

(defun process-next-action (plan-name); July 31/15;
;````````````````````````````````````` 
; As currently envisaged, 'plan-name' will always be the main Lissa
; plan, but in looking for the next action we potentially descend
; into subplans.
;
; I.e., we follow 'rest-of-plan' and 'subplan' pointers to find the
; next action in the current plan or subplan. If there are further
; actions, the car of the rest of the (sub)plan is the name of an action
; proposition, and the cdr begins with an action specification (a wff
; characterizing the implicit event-- whose name can be obtained by
; dropping the final period from the "action name"). 'Rest-of-plan'
; pointers become nil when a (sub)plan has been fully executed, but
; process-next-action only does this pointer-advancement when executing
; a primitive action, whereas updating the pointers for any higher-level
; actions is handled by 'update-rest-of-plan-pointers'.
;
; So, we process the action heading the rest of the (sub)plan, which
; for a primitive action entails execution of the action and advancement
; of the 'rest-of-plan' pointer of 'plan-name'. For a nonprimitive 
; action it leads to the creation of an initialized subplan intended
; to implement the nonprimitive action, with a name pointed to by
; the 'subplan' property of 'plan-name'. We hold off on executing the
; first step of such a subplan (leaving this to the next iteration
; of 'process-next-action' as called for in the main lissa program),
; in order to give the main plan management program (lissa) a chance
; to evaluate the "proposed" subplan and possibly make amendments.
; [This is just for future enhancements of the system, not immediately
; used.] 
;
; Question: Why not use the names of nonprimitive steps themselves as
; subplan names? Answer: We want to potentially allow for associating
; multiple alternative subplans with a given step (if we do this, we
; should change 'subplan' to 'subplans', which will point to a *list* 
; of subplan names); when one subplan fails, the step may still be
; achievable with an alternative subplan. (For user inputs, different
; subplans represent alternative expectations about user behavior, and
; this eventually opens the door to an AND-OR style of planning, as in
; two-person games.)
;
 (let* ({sub}plan-name (rest (get plan-name 'rest-of-plan)) wff)

       (if (null rest) (return-from process-next-action nil))
       ; i.e., no action; the loop in the main program will detect
       ; that 'rest-of-plan' is nil and the loop will be exited.

       ; Find the next action (at the lowest level), by following
       ; 'subplan' pointers (if any) to the deepest level where there
       ; is a subplan with a non-nil 'rest-of-plan' pointer.
       (setq {sub}plan-name (find-curr-{sub}plan plan-name))
             ; may (not) = plan-name
       (setq rest (get {sub}plan-name 'rest-of-plan))
       ;;(format t "~%'rest-of-plan' of currently due ~a is~% (~a ~a ...)~%"
        ;;          {sub}plan-name (car rest) (second rest)); DEBUGGING
       (setq wff (second rest))            

       (cond ; First we try to match '(me ...)' (Lissa) actions, typically
           ; one or more sentential utterances. However, the action heading
           ; 'rest-of-plan' may be nonprimitive, e.g., (me react-to.v ...)
           ; (unlike an immediately executable one such as (me say-to.v you
           ; '(...))), in which case it needs to be elaborated into a named
           ; subplan. (If the first step of this subplan, after initialization
           ; of the subplan, is again nonprimitive, the repeated calls to 
           ; 'process-next-action' in the main Lissa program will continue to
           ; elaborate the subplan until an initial primitive step is posited.)
           ; At present the elaboration process is just use of a choice tree
           ; or subschema that supplies the lower-level action(s) corresponding
           ; to the specified higher-level action.
           ; DEBUGGING
           ((eq (car wff) 'me) ; Lissa action
            (progn  (implement-next-lissa-action {sub}plan-name) (print ""))) ; also increments
                                         ; *count* for primitive lissa actions
                                
           ((eq (car wff) 'you) ; user action (input)
            (observe-next-user-action {sub}plan-name))
            ; The user actions are in principle hierarchically organized
            ; as well.
       )
 )); end of process-next-action


(defun find-curr-{sub}plan (plan-name); Sep 4/15
;`````````````````````````````````````
; Find the deepest subplan of 'plan-name' (starting with the action
; at the 'rest-of-plan' pointer of 'plan-name') with an immediately
; pending action.
;
 (let* ((rest (get plan-name 'rest-of-plan)) (act-propos-name (car rest)) 
        (wff (second rest)) (subplan-name (get act-propos-name 'subplan)))

;      (format t "~%  'rest-of-plan' of ~a is ~%   (~a ~a ...)"
;                 plan-name (car rest) (second rest)); DEBUGGING

       (cond ((null subplan-name); next action is top-level; it may be 
              plan-name)         ; primitive, or it may need elaboration
                                 ; into a subplan
             ((null (get subplan-name 'rest-of-plan)); unexpected: If
                                 ; the subplan is fully executed, then
                                 ; the 'update-rest-of-plan-pointers'-
                                 ; call in the main lissa program should
                                 ; have advanced the 'rest-of-plan' ptr
                                 ; of the (superordinate) 'plan-name'.
              (format t "~%**'find-curr-{sub}plan' applied to ~a ~
                  ~%   arrived at a completed subplan ~a" plan-name
                  subplan-name))

             (T; the subplan is not fully executed, so find & return
               ; the current {sub}subplan recursively:
               (find-curr-{sub}plan subplan-name)))
 )); end of find-next-{sub}action
 

(defun implement-next-lissa-action ({sub}plan-name); July 30/15
;`````````````````````````````````````````````````
; We assume that every {sub}plan name has a 'rest-of-plan' property
; pointing to the remainder of the plan that has not been fully executed
; (i.e., the first step of this remainder has been at most partially
; executed). Further, every action name for a nonprimitive action has,
; or needs to be supplied with, a 'subplan' property pointing to the
; name of a subplan, which will again have a 'rest-of-plan' property.
; Also, the subplan name will have a 'subplan-of' property that points
; back to the name of the action it expands.
;
; We assume that this program is called only if the first action of
; 'rest-of-plan' of '{sub}plan-name' is already known to be of type
; (me ...), i.e., an action by Lissa.
;
; NOTE FOR THE FUTURE: IT SEEMS THAT THIS PROGRAM COULD ITSELF BE
;   REFORMULATED AS A KIND OF CHOICE TREE THAT SELECTS A SUBPLAN
;   TO EXPAND A NONPRIMITIVE ACTION THAT IT FINDS AT THE 'REST-
;   OF-PLAN' POINTER, OR, FOR PRIMITIVE ACTIONS (SAYING WORDS),
;   EXECUTES THEM. WE MIGHT ULTIMATELY DEVELOP PLANS NON-SEQUENT-
;   IALLY, SEPARATING SUCH DEVELOPMENT FROM EXECUTION OF (CURRENTLY
;   DUE) PRIMITIVE ACTIONS. SO THE ROLE OF THE PLANNING EXECUTIVE
;   WOULD BE MORE IN THE NATURE OF "PRIORITIZING" -- DECIDING WHETHER
;   TO EXECUTE THE NEXT STEP (IF PRIMITIVE), OR WHAT PLAN STEPS TO  
;   ELABORATE, MODIFY, OR SHIFT AROUND NEXT, WHILE USING CHOICE 
;   TREES FOR FINDING SUITABLE METHODS FOR ELABORATION (AND DOING 
;   FREQUENT OVERALL CONSISTENCY, PROBABILITY, AND UTILITY 
;   CALCULATIONS).
;
; If the currently due action pointed to by the 'rest-of-plan'
; property of '{sub}plan-name' is primitive (e.g., saying something),
; execute it and advance the 'rest-of-plan pointer' of '{sub}plan-name'.
; Otherwise, if the 'subplan' property of the currently due action
; is nil, generate a subplan name, point to it via the 'subplan'
; property of the currently due action, find a choice tree or subschema
; for realizing the currently due action, and initialize the subplan.
;
; No part of the new subplan is immediately executed or further
; elaborated, so that the main Lissa plan manager can in principle
; check and amend the overall rest of the plan if necessary (e.g.,
; add or modify temporal constraints to avoid inconsistencies; more 
; radical changes may be warranted for optimizing overall utility).
; Any subschemas used in the elaboration process typically supply 
; multiple (me say-to.v you '(...)) actions), and choice packets used
; for step elaboration typically elaborate (me react-to.v ...) actions
; into single or multiple (me say-to.v you '(...)) subactions.
;
 (let* ((rest (get {sub}plan-name 'rest-of-plan))
        (lissa-action-name (car rest)) (wff (second rest)) bindings 
        expr user-action-name user-gist-clauses n user-gist-passage
        main-clause new-subplan-name info topic suggestion query )

;      (format t "~%WFF = ~a,~% in the LISSA action ~a being ~
;                       processed~%" wff lissa-action-name); DEBUGGING
       (cond 
             ; Saying
             ; ``````
             ((setq bindings
                    (bindings-from-ttt-match '(me say-to.v you _+) wff))
                       ; e.g., yields ((_+ '(I am a senior comp sci 
                       ; major\, how about you?))) (or nil, for non-match)
	      (setq expr (second (car bindings))); e.g., '(I am a ...)
              ; If the current "say" action is a question (which we assume
              ; can be seen from a final question mark -- to be safer, we
              ; could check for wh-words, "you", auxiliaries & other cues),
              ; then use 'topic-keys' and 'gist-clauses' of the current
              ; lissa-action-name and the *gist-kb* to see if the question
              ; already seems to have been answered. If so, change the
              ; {sub}plan to omit the current Lissa action: 
            ;(format t "~% **** expr is ~a **** ~%" expr)
            ;(format t "~% **** car expr is ~a **** ~%" (car expr))
              ;(when (obviated-question (car expr) lissa-action-name)
              ;(format t "~% ****Output of obviated-question**** ~a ~%" (not (null (obviated-question expr lissa-action-name))))
              (when (not (null (obviated-question expr lissa-action-name)))
                    (delete-current-action {sub}plan-name)
                    (delete-current-action {sub}plan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-lissa-action nil))
                    ; this will also reset the 'rest-of-plan' pointer
                    ; of '{sub}plan-name'.

              (cond ((eq (car expr) 'quote); drop the quote
                     (setq expr (second expr))
                     ; say it (and/or print it), also incrementing *count*,
                     ; and advance the 'rest-of-plan' pointer over the
                     ; initial "action name" and wff
                     (setq *count* (1+ *count*))
                     (if *live*
                         (say-words expr); the only overt output step
                         (print-words expr))
                     (setf (get {sub}plan-name 'rest-of-plan) (cddr1 rest))
                     ;(print-current-plan-status {sub}plan-name); DEBUGGING
                     (update-plan {sub}plan-name)
                     ;(print-current-plan-status {sub}plan-name); DEBUGGING
                    )
                    (T; nonprimitive (me say-to.v you ...)' action, perhaps
                      ; one like 
                      ;   (me say-to.v you (that (?e be.v finished.a)));
                      ; But actually, this should probably be an "illegal"
                      ; action specification because as seen below we can
                      ; (and should) consistently use 'tell.v' for inform-
                      ; acts. But for the moment, (me say-to.v you (that ...))
                      ; is handled, as equivalent to (me tell.v you (that ...))
                      (setq new-subplan-name (plan-tell-act expr))
                      ; Bidirectional hierarchy connections:
                      (setf (get lissa-action-name 'subplan) new-subplan-name)
                      (setf (get new-subplan-name 'subplan-of) 
                                                   lissa-action-name))))
             
             ; Reacting
             ; ````````
             ; For now, saying something is the only primitive action, so
             ; this point will be reached only for nonprimitive actions
             ((setq bindings
                    (bindings-from-ttt-match '(me react-to.v _!) wff))
                    ; e.g., yields ((_! EP34.)), or nil if unsuccessful;
              ; this nonprimitive action is to be expanded via choice packets.
              ;(format t "~%*** Step1 ~%" )
              (setq user-action-name (second (car bindings)))
             ; (format t "~% user action name is ~a ~%" user-action-name)
             ; (format t "~% user gist clause is ~a ~%" user-gist-clauses)
              (setq user-gist-clauses
                    (get user-action-name 'gist-clauses))
              ;(format t "~% user gist clause is ~a ~%" user-gist-clauses)
              (setq new-subplan-name
                    (plan-reaction-to user-gist-clauses))
              (when (null new-subplan-name)
                    (progn (delete-current-action {sub}plan-name) ;(print "~% We could not find any reaction ~%")
					)
                    (return-from implement-next-lissa-action nil))

              ; 'new-subplan-name' will be the name of a subplan, with either
              ; a single (me say-to.v you '(...)) step, or with multiple
              ; primitive or nonprimitive steps. Link lissa-action-name to
              ; this subplan, and conversely link the subplan to lissa-action-
              ; name, using a 'subplan-of' property (which might at some point
              ; be used in bidirectional plan traversals):
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name)
              ;(print "~% Step 1 ~%")
              ;(format t "~% user action name is ~a ~%" user-action-name )
              ;(format t "~% the gist clause is ~a ~%" user-gist-clauses )
              
              )

             ; Apart from saying and reacting, assume that Lissa actions
             ; also allow telling, describing, suggesting, asking, saying 
             ; hello, and saying good-bye. 
             ;
             ; (Other speech acts may be added later, such as proposing,
             ; rejecting, praising, advising, reprimanding, acknowledging,
             ; apologizing, exclaiming, etc.)
             ;
             ; Telling
             ; ```````
             ((setq bindings
                    (bindings-from-ttt-match '(me tell.v you _!) wff))
                    ; e.g., telling one's name could be formulated as
                    ;   (me tell.v you 
                    ;        (ans-to (wh ?x (me have-as.v name.n ?x)))),
                    ; and answer retrieval should bind ?x to a name. Or
                    ; we could have explicit reified propositions such as 
                    ;    (that (me have-as.v name.n 'Lissa)), or
                    ;    (that (me be.v ((attr autonomous.a) avatar.n))).
                    ; The match variable _! will have as binding the (wh ...)
                    ; expression.
              (setq info (second (car bindings)))
              (setq new-subplan-name (plan-tell-act info))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-lissa-action nil))
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name))

             ; Describing
             ; ``````````
             ; Describing, like telling, is an inform-act, but while
             ; telling simply conveys whatever propositions are given as
             ; argument, describing specifies what is to be conveyed at
             ; an abstract level, e.g., describing "who I am" (which may
             ; involve supplying a name, type, age, and the like), or
             ; describing one's capabilities, someone's appearance, one's
             ; family, or "what I like about Rochester", etc. This of course
             ; involves access to knowledge in the appropriate categories,
             ; and this may then be further expanded via tell-acts.
             ;
             ; In general, describing is a severe challenge in NLG, but
             ; here it will be initially assumed that we have schemas for
             ; expanding any descriptive actions that a plan might call
             ; for. An even simpler way of packaging related sets of
             ; sentences for ouput is to just use a tell-act of type
             ;    (me tell.v you (meaning-of.f '(<sent1> <sent2> ...)))
             ; where the 'meaning-of.f' function applied to English
             ; sentences supplies their semantic interpretation (reified
             ; with the 'that' operator) -- which of course needn't
             ; actually be computed (unless we wish to paraphrase the
             ; English in some way). Combining the two ideas, we can
             ; provide schemas for expanding a describe-act directly into
             ; a tell-act with a complex (meaning-of.f '(...)) argument.
             ;
             ((setq bindings
                    (bindings-from-ttt-match '(me describe-to.v you _!) wff))
              (setq topic (second bindings))
              ; e.g., (th (main.a (plur characteristic-of.n me)))
              (setq new-subplan-name (plan-description topic))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-lissa-action nil))
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name))
                    
             ; Suggesting
             ; ``````````
             ((setq bindings
                    (bindings-from-ttt-match '(me suggest-to.v you _!) wff))
              (setq suggestion (second bindings))
              ; e.g., suggestion = 
              ;         (that (you provide-to.v me
              ;                   (K ((attr extended.a) (plur answer.n)))))
              (setq new-subplan-name (plan-suggest-act suggestion))
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name))

             ; Asking
             ((setq bindings
                    (bindings-from-ttt-match '(me ask.v you _!) wff))
              (setq query (second bindings))
              ; e.g., query = (ans-to (wh ?x (you have-as.v major.n ?x)))
              (setq new-subplan-name (plan-question query))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-lissa-action nil))
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name))
             
             ; Saying hello
             ; ````````````
             ((equal wff '(me say-hello-to.v you))
              (setq new-subplan-name (plan-saying-hello))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-lissa-action nil))
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name))
             
             ; Saying good-bye
             ; ```````````````
             ((equal wff '(me say-bye-to.v you))
              (setq new-subplan-name (plan-saying-bye))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-lissa-action nil))
              (setf (get lissa-action-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) lissa-action-name))

             (T (format t "~%*** UNRECOGNIZABLE STEP ~a " wff))
           )
 )); end of implement-next-lissa-action


(defun observe-next-user-action ({sub}plan-name); Aug 3/15
;````````````````````````````````````````````````
; '{sub}plan-name' provides the name of a (sub)plan whose
; 'rest-of-plan' pointer points to a user action, i.e., the
; name of a user action followed by a wff of type (you ...).
;
; We build a two-level plan structure for nonprimitive user
; replies (with a (you say-to.v me '(...)) at the primitive
; level), and (in another Lissa plan iteration) "interpret" 
; these replies. The value returned is a pair 
;    (<user action name> <corresponding wff>) 
; for the step that was processed. (This is not needed but 
; may help in debugging.)
;
; The idea is that we should recognize user actions as being
; hierarchically organized (just like Lissa actions). 
; Currently we're just anticipating nonprimitive top-level
; actions like 
;        (you reply-to.v <lissa action>)
; that we expand to one further, primitive level of type
;        (you say-to.v me '(...)) 
; actions. However, in principle, observing a user action
; is a plan-recognition process, where for example multiple 
; sentences uttered by the user may comprise a sequence of
; speech acts of different types (just like outputs by Lissa);
; as well, the highest-level user plan that is recognized may
; fail to match the *expected* type of the user action (but
; we're ignoring this possibility for now).
;
; Primitive user actions arise in two ways: First, (you say-to.v
; me '(...)) actions are generated here from nonprimitive
; (you reply-to.v ...) actions as already mentioned and explained
; further below. Second, Lissa actions of type (Me react-to.v ...)
; may generate schema-based subplans that contain multiple Lissa
; comments of type (Me say-to.v you '(...)), where these are
; preceded by "hallucinated" user inputs of form (You paraphrase.v
; '(...)); here the quoted words comprise a gist clause "attributed"
; to the user, i.e., these are treated as implicit versions of 
; (parts of) the user's previous actual input that were "para-
; phrased" by the user in the context of the Lissa question they
; answer. These "hallucinated" clauses attributed to the user are
; needed to enable uniform processing of Lissa's reaction to each
; individual gist clause derived from an actual input.
;
; To generate a subplan containing a primitive (you say-to.v me 
; '(...)) action, given a (you reply-to.v <lissa action>) action, 
; we read the user input, form a wff for the primitive action with
; the input word list filled in, generate a plan name for the
; simple subordinate plan, and assign a value to that plan name
; consisting of a new action name for the primitive action and the
; (you say-to.v ...) wff. We don't make interpretation of the 
; user input part of the process of generating the primitive 
; action (though we could, since we have at hand the <lissa action>
; to which the user is responding, in the wff (you reply-to.v 
; <lissa action>)); instead, we derive the interpretation when
; processing the primitive action; this is for consistency with
; the general principle that interpretation (including speech act
; recognition) should proceed bottom-up (but with the previous 
; Lissa utterance as context). [However, maybe hierarchical
; interpretation should be a process separate from hierarchical
; plan processing...]
; 
; So, processing of primitive (you say-to.v me '(...)) actions
; should lead to their "interpretation", i.e., extraction of gist
; clauses and possibly supplementary information that could
; obviate later Lissa questions. This requires finding out what
; the user is replying to, by looking "upward" and "backward" in the
; plan hierarchy. Specifically, we need to access the nonprimitive
; user action that immediately subsumes the (you say-to.v me ...)
; action -- this is accessible via the 'subplan-of' property of
; {sub}plan-name -- and the wff of this noprimitive action in turn
; supplies the name of the Lissa action that the user is responding
; to. The 'gist-clauses' property of that Lissa action name leads 
; to the desired context information for interpreting the user input 
; utterance. (In future the 'interpretation' property is to be used.)
; 
 (let* ((rest (get {sub}plan-name 'rest-of-plan))
        (user-action-name (car rest)) (wff (second rest))
        bindings words user-action-name1 wff1 lissa-action-name 
        lissa-clauses user-gist-clauses main-clause subplan-name
        input)
;      (format t "~%WFF = ~a,~%      in the user action ~a being ~
;                       processed~%" wff user-action-name); DEBUGGING
       (cond ; we deal with primitive say-actions first (previously
             ; created from (you reply-to.v <lissa action>)) based on
             ; reading the user input:
             ((setq bindings
                   (bindings-from-ttt-match '(you say-to.v me _!) wff))
	      (setq words (second (car bindings))); e.g., '(I am in math)
              ; Anything but a quoted word list is unexpected:
              (when (not (eq (car words) 'quote))
                    (format t "~%*** SAY-ACTION ~a~%    BY THE USER ~
                      SHOULD SPECIFY A QUOTED WORD LIST" words)
                    (return-from observe-next-user-action nil))
                     
              ; drop the quote
              (setq words (second words))
              ; Prepare to "interpret" 'words', using the Lissa output
              ; it is a response to; first we need the superordinate 
              ; action:
              (setq user-action-name1
                    (get {sub}plan-name 'subplan-of))
              ;(format t "~%User action name1 = ~a" user-action-name1); DEBUGGING
             
			  ; Next we find the Lissa action name referred to in
              ; the wff of the (nonprimitive) superordinate action;
              ; this wff is expected to be of form (you reply-to.v
              ; <lissa action>)
              (setq wff1 (get user-action-name1 'wff)); nonprim. wff
;             (format t "~%User WFF1 = ~a, if correct,~%            ~
;                        ends in a LISSA action name" wff1); DEBUGGING
              (setq lissa-action-name (car (last wff1)))
              (when (not (symbolp lissa-action-name))
                    (format t "~%***UNEXPECTED USER ACTION ~A" wff)
                    (return-from observe-next-user-action nil))
              ; Next, the "interpretation" (gist clauses) of the 
              ; Lissa action:
              (setq lissa-clauses 
                           (get lissa-action-name 'gist-clauses))
             ;(format t "~%LISSA action name is ~a" lissa-action-name)
             ;(format t "~%LISSA gist clauses that the user is responding to ~
              ;          ~% = ~a " lissa-clauses); DEBUGGING
              ; (In future we might instead or in addition use
              ;     (get lissa-action-name 'interpretation).)
              ; Compute the "interpretation" (gist clauses) of the
              ; user input, which will be done with a gist-clause
              ; packet selected using the main Lissa action clause,
              ; and with the user input being the text to which the
              ; tests in the gist clause packet (tree) are applied.
              ; The *gist-clause-trees* top-level packet & the
              ; packets it delegates to will be used:
             ; (format t "~% lissa clauses = ~a" (car (last lissa-clauses)))
			 ; (format t "~% words = ~a" words)
			  
              (setq user-gist-clauses
                    (form-gist-clauses-from-input ; for now the context
                              ; used is just the last LISSA gist clause
                                        words (car (last lissa-clauses))))
              ;(format t "~% this is the gist clause = ~a" user-gist-clauses)
              ; Both the primitive user action and the immediately
              ; subordinate action receive the gist-clause interpret-
              ; ation just computed.
              (setf (get user-action-name 'gist-clauses)
                    user-gist-clauses)
              (setf (get user-action-name1 'gist-clauses)
                    user-gist-clauses)
              ; Advance the rest-of-plan' pointer of the primitive
              ; plan past the action name and wff just processed, and
              ; initialize the next action (if any):
              (setf (get {sub}plan-name 'rest-of-plan) (cddr1 rest))
              ;(print-current-plan-status {sub}plan-name); DEBUGGING
              (update-plan {sub}plan-name)
              ;(print-current-plan-status {sub}plan-name); DEBUGGING
              (list user-action-name wff)); return pair (helps debugging)

             ; Next we deal with gist clauses "attributed" to the user,
             ; in user actions of form
             ;    '(you paraphrase.v '<gist clause>')'
             ; in a subplan derived from a schema for handling complex
             ; user turns; i.e., we take the view that the user paraphrased
             ; these gist clauses in his/her original, often "condensed", 
             ; sentences; thus we can directly set the 'gist-clauses' 
             ; properties of the user action (needed for Lissa's reaction), 
             ; rather than applying 'form-gist-clauses-from-input' again
             ; (as was done above for (you say-to.v me '(...)) actions)
             ((setq bindings
                   (bindings-from-ttt-match '(you paraphrase.v _!) wff))
              (setq words (second (car bindings)))
              (when (not (eq (car words) 'quote))
                    (format t "~%*** PARAPHRASE-ACTION ~a~%    BY THE USER ~
                      SHOULD SPECIFY A QUOTED WORD LIST" words)
                    (return-from observe-next-user-action nil))
              (setq user-gist-clauses     ; drop quote, thus leaving
                              (cdr words)); a singleton list of clauses
              (setf (get user-action-name 'gist-clauses)
                    user-gist-clauses)
              ; Advance the rest-of-plan' ptr of the primitive plan
              ; past the action name and wff just processed, and
              ; initialize the next action (if any):
              (setf (get {sub}plan-name 'rest-of-plan) (cddr1 rest))
              ;(print-current-plan-status {sub}plan-name); DEBUGGING
              (update-plan {sub}plan-name)
              ;(print-current-plan-status {sub}plan-name); DEBUGGING
              (list user-action-name wff)); return pair (helps debugging)

             (T; nonprimitive (you reply-to.v <lissa action name>)' action;
               ; We particularize this action as a subplan, based on reading
               ; the user input:
               (setq input 
                     (if *live* (hear-words) (read-words)))
	       ; Make sure that any final punctuation, such as ?, ., or !,
	       ; is separated from the final word (so as not to impair
	       ; pattern matching). [However, note that 'hear-words' and
	       ; 'read-words' already separate off any punctuation other 
	       ; than "'", "_", or "-"]
               (when (null input)
                     (delete-current-action {sub}plan-name)
                     (return-from observe-next-user-action nil))
               (setq input (detach-final-punctuation input))
;              (format t "~%echo of input: ~a" input); DEBUGGING
               (setq wff1 `(you say-to.v me (quote ,input)))
;              (format t "~%echo of WFF1 ~a" wff1); DEBUGGING
               (setq user-action-name1; starting with "A" % with final "."
                     (intern (format nil "~a." (gensym "A"))))
               (setf (get user-action-name1 'wff) wff1)
               (setq subplan-name (gensym "SUBPLAN"))
               (set subplan-name ; [maybe this is not really needed...]
                     (list :actions user-action-name1 wff1))
               (setf (get subplan-name 'rest-of-plan) 
                     (cdr (eval subplan-name))); cdr past ':actions'
               ; Bidirectional hierarchical connections:
               (setf (get subplan-name 'subplan-of) user-action-name)
               (setf (get user-action-name 'subplan) subplan-name)
               ;(print-current-plan-status subplan-name); DEBUGGING
               (list user-action-name1 wff1) )); (again, for debugging)
 )); end of observe-next-user-action


(defun obviated-question (sentence lissa-action-name); Aug 28/15
;````````````````````````````````````````````````````
; Check whether this is a (quoted, bracketed) question.
; If so, check what facts, if any, are stored in *gist-kb* under 
; the 'topic-keys' obtained as the value of that property of
; 'lissa-action-name'. If there are such facts, check if they
; seem to provide an answer to the gist-version of the question,
; which will be the last gist clause stored under property
; 'gist-clauses' of 'lissa-action-name'.
;
 (prog (topic-keys facts)
      ; (format t "~% ****** quoted question returns ~a **** ~%" (quoted-question? sentence))
       (if (not (quoted-question? sentence))
           (return nil))
       (setq topic-keys (get lissa-action-name 'topic-keys))
       ;(format t "~% ****** topic key is ~a ****** ~%" topic-keys)
       (if (null topic-keys) (return nil))
       (setq facts (gethash topic-keys *gist-kb*))
       ;(format t "~% ****** gist-kb ~a ****** ~%" *gist-kb*)
       ;(format t "~% ****** list facts about this topic = ~a ****** ~%" facts)
       ;(format t "~% ****** There is no fact about this topic. ~a ****** ~%" (null facts))
     
       (if (null facts) (return nil))
       ; We have a Lissa question, corresponding to which we have
       ; stored facts (as user gist clauses) that seem topically
       ; relevant.
       ; ** In this simple initial version, we don't try to verify
       ;    that the facts actually obviate the question, but just
       ;    assume that they do:
       (return facts)
 )); end of obviated-question
 

(defun quoted-question? (sentence); Aug 28/15
;`````````````````````````````````
; Is sentence of form (quote (<word> ... <word> ?)), or with the
; question mark attached to the last word? (One could make more
; elaborate checks that would also work w/o a question mark, using
; patterns (... <aux> you{r} ...), (... <wh-word> <word> you{r} ...),
; etc.). But we assume we have ensured that output questions end in
; "?".
 (let (word)
      ;(format t "~% ****** quoted-question? first line = ~a **** ~%" (listp sentence))
      ; (format t "~% ****** quoted-question? third line = ~a **** ~%" sentence)
      (if (and (listp sentence) (eq (car sentence) 'quote)
               (listp (second sentence)))
          (setq word (car (last (second sentence))))
          (return-from quoted-question? nil))
      (or (eq word '?) 
          (char-equal #\? (car (last (explode word)))))
 )); end of quoted-question?
                    

(defun delete-current-action ({sub}plan-name); Aug 28/15
;````````````````````````````````````````````
; Skip over the action of {sub}plan-name pointed to by its 
; 'rest-of-plan' pointer. Actually, the original intention was
; to destructively delete obviated actions, so that the executed
; plan accurately reflects what actually occurred. However,
; since plans are currently represented as simple list structures,
; rather than doubly-linked lists, we would have to search from
; the beginning of the plan to find the point where we'd need
; to apply 'rplaca' to physically delete the name (and then wff)
; of the skipped action. Ultimately, to facilitate general plan
; modifications, rearrangements, etc., we should be using a doubly
; linked list -- perhaps record-structures for steps that have
; fields for preceding and following steps (and wff fields, gist
; clause fields, etc.)
;
;(format t "~% CURRENT ACTION ~a BEING DELETED FROM ~a, ALONG WITH ITS ~
;           ~%  WFF = ~a" (car (get {sub}plan-name 'rest-of-plan)) {sub}plan-name 
;                        (second (get {sub}plan-name 'rest-of-plan))); DEBUGGING
                      
 (setf (get {sub}plan-name 'rest-of-plan) 
       (cddr1 (get {sub}plan-name 'rest-of-plan)))
;(format t "~% So the next plan is now  ~a" (get {sub}plan-name 'rest-of-plan))  
 (update-plan {sub}plan-name)
); end of delete-current-action


(defun plan-reaction-to (user-gist-clauses); Aug. 5-21/15
;`````````````````````````````````````````````````````````
;
; Starting at a top-level choice tree root, choose an action or
; subschema suitable for reacting to 'user-gist-clauses' (which
; is one or more sentences, without tags (and with a final detached
; "\." or "?"), that try to capture the main content (gist) of
; a user input). Return the (new) name of a plan for realizing 
; that action or subschema.
;
; If the action arrived at is a particular verbal output (instantiated
; reassembly pattern, where the latter was signalled by directive :out, 
; & is indicated by ':out' in the car of the 'choose-result-for' result), 
; form a plan with one action, viz. the action of saying that verbal 
; output.
;
; If the action arrived at is another choice tree root (signalled by
; directive :subtree), this will be automatically pursued recursively
; in the search for a choice, ultimately delivering a verbal output
; or a schema name.
;
; If the action arrived at is a :schema+args "action" (a schema name
; along with an argument list), use this schema to form a subplan.
;
; ** Should the new subplan name also receive an 'semantics'
; property? ... We don't really expect a further user response to these
; reactive comments from Lissa, which would then need to be understood
; in light of the meaning of these reactive comments...More thought
; required.
;
 (let (user-gist-words choice tagged-words wff subplan-name 
       action-prop-name schema-name args)

      (if (null user-gist-clauses)
          (return-from plan-reaction-to nil))
          
      ; We use either choice tree '*reaction-to-input*' or
      ; '*reactions-to-input*' (note plural) depending on whether
      ; we have one or more gist clauses. (The selection could be 
      ; combined into a single choice tree, but we use three for
      ; perspicuity.)
      (cond ((null (cdr user-gist-clauses)); single clause?
             (setq tagged-words 
                   (mapcar #'tagword (car user-gist-clauses)))
             ;(format t "~% tagwords are ~a ~% " tagged-words)
             (setq choice (choose-result-for tagged-words 
                                           '*reaction-to-input*))
			 ;(format t "~% choice are ~a ~% " choice)  
			 )

            (T ; there are multiple gist clauses;
               ; concatenate (to enable pattern matching by the current
               ; 'match' function) -- gist clauses are assumed to be 
               ; puctuated, so concatenation leaves sentence boundaries
               ; recognizable by the matcher.
               (setq user-gist-words (apply 'append user-gist-clauses))
               ;(format t "~% user-gist-words are ~a ~% " user-gist-words)
			   (setq tagged-words (mapcar #'tagword user-gist-words))
               ;(format t "~% tagwords are ~a ~% " tagged-words)
			   (setq choice (choose-result-for tagged-words
                                           '*reactions-to-input*))
			   ;(format t "~% choice are ~a ~% " choice)
			   						   ))

      (if (null choice) (return-from plan-reaction-to nil))

      ; 'choice' may be an instantiated reassembly pattern (prefaced
      ; by directive :out), or the name of a schema (to be initialized).
      ; In the first case we create a 1-step subplan whose action
      ; is of type
      ;          (me say-to.v you '(...)),
      ; where the verbal output has been adjusted by applying 
      ; 'modify-response' to the instantiated reassembly patterns
      ; (forming duals & introducing clitics, etc.) In the second
      ; case, we initiate a multistep plan.
      
      (setq subplan-name (gensym "SUBPLAN"))
      (cond ((eq (car choice) :out); a verbal reaction
             (setq choice (modify-response (cdr choice))); drop key ':out'
                                                         ; and adjust
             (setq wff `(me say-to.v you (quote ,choice)))
             ; we want the action proposition name to terminate in 
             ; a period:
             (setq action-prop-name 
                   (intern (format nil "~a." (string (gensym "A")))))
             ; build the 1-step plan:
             (setf (get action-prop-name 'wff) wff)
             (set subplan-name ; let its value be the (1-step) plan
                               ; (** not sure if we really need this,
                               ; since we also set 'rest-of-plan')
                  (list :actions action-prop-name wff))
             (setf (get subplan-name 'rest-of-plan)
                   (cdr (eval subplan-name))); cdr past ':actions'
             subplan-name); return the name of the 1-step plan
			 
			 ; I found no evidence of this directive being implemented
			 ; anywhere, so I added it. -PM
			((eq (car choice) :schema)
			    (setq schema-name (first (cdr choice)))
			    (set subplan-name
				    (initialize-plan subplan-name schema-name nil)))
			 
            ((eq (car choice) :schema+args)
             ; we assume that the cdr of 'choice' must then be of form 
             ;          (<schema name> <argument list>)
             ; The idea is that the separate pieces of the word sequence
             ; supply separate gist clauses that Lissa may react to in 
             ; the steps of the schema. These are provided as sublists
             ; in <argument list>.
             ;
             ; Such schemas might produce a complex output such as "I
             ; don't know Rochester well enough to say what I like or
             ; dislike about it. But concerning your comment, that would 
             ; bother me too", where this joins two reactions produced
             ; by choice trees with a discourse phrase (But concerning 
             ; your comment). Another arrangement be "That would bother 
             ; me too; as for me, I don't know Rochester well enough to
             ; say what I like or about it." So the schema would produce 
             ; 3 steps of type (me say-to.v you '(...)), to sequence the
             ; 3 pieces.
             (setq schema-name (first (cdr choice))
                   args (second (cdr choice)))
             ; So, instantiate the schema, and initialize the subplan:
             (set subplan-name ; N.B. (cdr choice) = the schema name
                  (initialize-plan subplan-name schema-name args))))
 )); end of plan-reaction-to


(defun choose-result-for (tagged-clause rule-node); Sep 6/15
;````````````````````````````````````````````````
; This is just the top-level call to 'choose-result-for', with
; no prior match providing a value of 'parts', i.e., 'parts' = nil;
; this is to enable tracing of just the top-level calls
 (choose-result-for1 tagged-clause nil rule-node) )


(defun choose-result-for1 (tagged-clause parts rule-node); Aug 14-26/15
  ;`````````````````````````````````````````````````````
  ; This is a generic choice-tree search program, used both for
  ; (i) finding gist clauses in user inputs (starting with selection
  ; of appropriate subtrees as a function of Lissa's preceding
  ; question, simplified to a gist clause), and (ii) in selecting
  ; outputs in response to (the gist clauses extracted from) user 
  ; inputs. Outputs in the latter case may be verbal responses
  ; obtained with reassembly rules, or names (possibly with
  ; arguments) of other choice trees for response selection, or
  ; the names (possibly with arguments) of schemas for planning 
  ; an output. The program works in essentially the same way for
  ; purposes (i) and (ii), but returns
  ;      (cons <directive keyword> result)
  ; where the directive keyword (:out, :subtree, :subtree+clause,
  ; :schema, ...) is the one associated with the rule node that
  ; provided the final result to the calling program. (The calling
  ; program is presumed to ensure that the appropriate choice tree
  ; is supplied  as 'rule-node' argument, and that the result is
  ; interpreted and used as intended for that choice tree.)
  ;
  ; So, given a feature-tagged input clause 'tagged-clause', a list 
  ; 'parts' of matched parts from application of the superordiate
  ; decomposition rule (initially, nil), and the choice tree node 
  ; 'rule-node' in a tree of decomposition/result rules, we generate
  ; a verbal result or other specified result starting at that rule,
  ; prefixed with the directive keyword.
  ;
  ; Decomposition rules (as opposed to result rules) have no
  ; 'directive' property (i.e., it is NIL). Note that in general
  ; a decomposition rule will fail if the pattern it supplies fails
  ; to match 'tagged-clause', while a result rule will fail if its
  ; latency requirements prevent its (re)use until more system
  ; outputs have been generated. (This avoids repetitive outputs.)
  ;
  ; Note also that result rules can have siblings, but not children,
  ; since the "downward" direction in a choice tree corresponds to
  ; successive refinements of choices. Further, note that if the
  ; given rule node provides a decomposition rule (as indicated by
  ; a NIL 'directive' property), then it doesn't make any direct
  ; use of the 'parts' list supplied to it -- it creates its own
  ; 'newparts' list via a new pattern match. However, if this
  ; match fails (or succeeds but the recursion using the children 
  ; returns NIL), then the given 'parts' list needs to be passed
  ; to the siblings of the rule node -- which after all may be 
  ; result rules, in particular reassembly rules.
  ;
  ; Method:
  ; ```````
  ; If the rule has a NIL 'directive' property, then its 'pattern'
  ; property supplies a decomposition rule. We match this pattern,
  ; and if successful, recursively seek a result from the children
  ; of the rule node (which may be result rules or further decomp-
  ; osition rules), returning the result if it is non-nil; in case
  ; of failure, we recursively return a result from the siblings
  ; of the rule node (via the 'next' property); these siblings
  ; represent alternatives to the current rule node, and as such
  ; may be either alternative decomposition rules, or result rules 
  ; (with a non-nil 'directive' property) -- perhaps intended as
  ; a last resort if the decomposition rules at the current level
  ; fail.
  ;
  ; In all cases of non-nil directives, if the latency requirement
  ; is not met, i.e., the rule cannot be reused yet, the recursive
  ; search for an result continues with the siblings of the rule.
  ;
  ; If the rule node has directive property :out, then its 'pattern'
  ; property supplies a reassembly rule. If the latency requirement 
  ; of the rule is met, the result based on the reassembly rule and
  ; the 'parts' list is returned (after updating 'time-last-used'). 
  ; The latency criterion uses the 'latency' property of 'rule-node' 
  ; jointly with the 'time-last-used' property and the global result 
  ; count, *count*. 
  ;
  ; If the rule node has directive property :subtree, then 'pattern'
  ; will just be the name of another choice tree. If the latency 
  ; requirement is met, a result is recursively computed using the
  ; named choice tree (with the same 'tagged-clause' as input).
  ; The latency will usually be 0 in this case, i.e., a particular
  ; choice subtree can usually be used again right away.
  ;
  ; If the rule node has directive property :subtree+clause, then
  ; 'pattern' supplies both the name of another choice tree and
  ; a reassembly pattern to be used to construct a clause serving
  ; as input in the continued search (whereas for :subtree the
  ; recursion continues with the original clause). Again the
  ; latency will usually be 0.
  ;
  ; Other directives are 
  ; - :subtrees (returning the names of multiple subtrees (e.g., 
  ;   for extracting different types of gist clauses from a 
  ;   potentially lengthy user input); 
  ; - :schema (returning the name of a schema to be instantiated, 
  ;   where this schema requires no arguments); 
  ; - :schemas (returning multiple schema names, perhaps as 
  ;   alternatives); 
  ; - :schema+args (a schema to be instantiated for the specified 
  ;   args derived from the given 'tagged-clause'); 
  ; - :gist (a gist clause extracted from the given 'tagged-clause,
  ;   plus possibly a list of topic keys for storage);
  ; - perhaps others will be added, such as :subtrees+clauses or
  ;   :schemas+args
  ;
  ; These cases are all treated uniformly -- a result is returned
  ; (with the directive) and it is the calling program's responsib-
  ; ility to use it appropriately. Specifically, if the latency
  ; requirement is met, the value supplied as 'pattern', instantiated
  ; with the supplied 'parts', is returned. (Thus integers appearing
  ; in the value pattern are interpreted as references to parts
  ; obtained from the prior match.) 
  ;
  (prog (directive pattern newparts newclause new-tagged-clause result) 
	(if (null rule-node) (return nil)); don't use empty choice trees

        (setq directive (get rule-node 'directive))
	(setq pattern 
              (get rule-node 'pattern)); reassembly pattern or other
                              ; result object (for non-nil directive);
        (when (and directive     ; an output node?
                   *use-latency* ; latency being enforced?
                   (< *count* ; have too few results been generated
                              ; to allow re-use of the result rule?
                     (+ (get rule-node 'time-last-used); initially -100
                        (get rule-node 'latency))))
              (return (choose-result-for1 tagged-clause parts 
				              (get rule-node 'next) )))
	;;(format t "~% ***1*** Tagwords = ~% ~a " tagged-clause); DEBUGGING			              
      ;;  (format t "~% =====2==== Pattern/output to be matched in rule ~a = ~
        ;;        ~%  ~a and directive = ~a" rule-node pattern directive); DEBUGGING
        (cond ((null directive); look depth-first for more specific match
                               ; and if that fails, try alternatives
               (setq newparts (match pattern tagged-clause))
            ;;   (format t "~% ----3---- new part = ~a ~%" newparts)
            ;;   (if *tracerules*
            ;;       (format t "~%@@ Rule ~s with pattern ~s tried on input ~
            ;;         ~%         ~s~%        yielding parts ~%         ~s"
            ;;                      rule-node pattern tagged-clause parts))
               (if (null newparts); pattern does not match 'tagged-clause'
                   (return ; search siblings (alternatives) recursively
                     (choose-result-for1 tagged-clause 
                                        parts (get rule-node 'next))))
               (setq result ; pattern matched; try to obtain recursive 
                            ; result from children of the node
                     (choose-result-for1 tagged-clause 
                                     newparts (get rule-node 'children)))
               (if result (return result)
                   (return (choose-result-for1 tagged-clause 
                                         parts (get rule-node 'next)))))

              ((eq directive :subtree)
               ; recursively obtain a result from the choice tree
               ; (specified via its root name, given as 'pattern'):
               (setf (get rule-node 'time-last-used) *count*)
               (return 
                  (choose-result-for1 tagged-clause parts pattern)))
               ;             We might use NIL here ^^^^^, expecting to
               ;             do a brand-new search, but there's no harm
               ;             in potentially treating the given subtree
               ;             as if it were part of the current one.

              ((eq directive :subtree+clause)
               ; This is similar to :subtree, except that 'pattern' is
               ; not simply the root name of a tree to be searched, but
               ; rather a pair of form
               ;    (<root name of tree> <reassembly pattern>),
               ; indicating that the reassembly pattern should be used
               ; together with 'parts' to reassemble some portion of 
               ; 'tagged-clause', whose result should then be used 
               ; (after re-tagging) in the recursive search.
               (setf (get rule-node 'time-last-used) *count*)
               (setq newclause 
                 (instance (second pattern) parts)); assemble new clause
               (setq new-tagged-clause (mapcar #'tagword newclause))
               (return
                  (choose-result-for1 new-tagged-clause nil 
                                           (car pattern)))); = root name

              ((member directive '(:out :subtrees :schema :schemas 
                                                    :schema+args :gist))
               ; We have already done the latency check, so we can 
               ; return the result of reassembly:
               (setq result (cons directive (instance pattern parts)))
               (setf (get rule-node 'time-last-used) *count*)
               (return result))

	      (T ; directive is not recognized
                 (format t "~%*** UNRECOGNIZABLE DIRECTIVE ~s ENCOUNTERED ~
                   FOR RULE ~s~%    FOR THE FOLLOWING PATTERN AND TAGGED ~
                   CLAUSE: ~%    ~s,  ~s" directive rule-node pattern
                   tagged-clause)))
 )) ; end of choose-result-for1


(defun plan-tell-act (info); TBC
;```````````````````````````
; Return the name of a plan for telling the user the 'info';
; 'info' is a reified proposition that may be in a form that makes
; verbalization trivial, e.g.,
;     (meaning-of.f '(I am Lissa. I am an autonomous avatar.))
; where the 'meaning-of.f' function in principle provides EL
; propositions corresponding to English sentences -- i.e., semantic
; parser output, reified using 'that'; but of course, for verbal-
; ization we don't need to first convert to EL! Or else the info 
; is directly in EL form, e.g.,
;     (that (me have-as.v name.n 'Lissa)), or
;     (that (me be.v ((attr autonomous.a) avatar.n))),
; which requires English generation for a fully expanded tell
; act.
;
 (if (null info) (return-from plan-tell-act nil))
 ; TBC
 ); end of plan-tell-act


(defun plan-description (topic)
;`````````````````````````````  TBC
 (if (null info) (return-from plan-description nil))
 ; TBC
 ); end of plan-description


(defun plan-suggest-act (suggestion)
;```````````````````````````````````  TBC
 (if (null suggestion) (return-from plan-suggest-act nil))
 ; TBC
 ); end of plan-suggest-act


(defun plan-question (query)
;```````````````````````````  TBC
 (if (null query) (return-from plan-question nil))
 ; TBC
 ); end of plan-question


(defun plan-saying-hello ()
;``````````````````````````  TBC
 ); end of plan-saying-hello


(defun plan-saying-bye ()
;````````````````````````  TBC
 ); end of plan-saying-bye


(defun detach-final-punctuation (wordlist); Aug 5/15
;````````````````````````````````````````
 (if (null wordlist) (return-from detach-final-punctuation nil))
 (let* ((lastword (car (last wordlist))) (chars (explode lastword)) 
        ch punc)
       (if (= (length chars) 1)
           (return-from detach-final-punctuation wordlist))
       (cond ((setq ch (find (car (last chars)) '(#\. #\? #\! #\;)))		
                        ; not sure if this should be included ^^^
              (setq lastword (implode (butlast chars)))
              (setq punc (implode (list ch)))
	      (append (butlast wordlist) (list lastword) (list punc)))
             (T wordlist))
 )); end of detach-final-punctuation


(defun form-gist-clauses-from-input (words prior-gist-clause)
;````````````````````````````````````````````````````````````
; Find a list of gist-clauses corresponding to the user's 'words',
; interpreted in the context of 'prior-gist-clause' (usually a
; question output by the system). Use hierarchically related 
; choice trees for extracting gist clauses.
;
; The gist clause extraction patterns will be similar to the
; ones in the choice packets for reacting to inputs, used in
; the previous version; whereas the choice packets for reacting
; will become simpler, based on the gist clauses extracted from
; the input.
;
; We use 3 sorts of strategies in extracting gist clauses,
; based on three choice trees aimed at each of the user
; responses to Lissa's questions:
;
; - pattern-match successive 10-word windows, shifted 5 words
;   at a time (but including any immediately preceding negation
;   word, like "no", "not", "don't", "cannot" or "never" in
;   the 10-word window; accumulate results, remove duplicates;
;
;   This might use choice trees such as
;      *specific-answer-from-major-input*,
;      *specific-answer-from-favorite-class-input*,
;      etc.
;
; - do a kind of statistical pattern match where we look
;   for as many words/phrases of a particular category as
;   possible (e.g., names of TV series, names of restaurants,
;   literature references like fiction/nonfiction/book/novel/
;   read/journal/...); prevalence of certain types of phrases
;   tend to indicate a preference or interest.
;
;   This might use choice trees such as
;       *thematic-answer-from-major-input*,
;       *thematic-answer-from-favorite-class-input*,
;       etc.
;
; - look for a final question -- either yes-no, starting
;   with auxiliary + "you{r}", or wh-question, starting with
;   a wh-word and with "you{r}" coming within a few words.
;   "What about you" isa fairly common pattern. (Sometimes the
;   wh-word is not detected but "you"/"your" is quite reliable.)
;   The question, by default, is reciprocal to Lissa's question.
;
;   This might use choice trees such as
;       *question-from-major-input*,
;       *question-from-favorite-class-input*,
;       etc.
;
;   Sometimes there are final suggestions instead of questions,
;   like "you should check it out"; those might be worth looking
;   for (& replying "Maybe I will", or just "OK", and then go on).
;
;   If implemented, this might use choice trees such as
;       *suggestion-from-major-input*,
;       *sggestion-from-favorite-moview-input*
;       etc.
;   [** Not handled yet]    
;
 (let ((n (length words)) tagged-prior-gist-clause relevant-trees 
        specific-content-tree unbidden-content-tree thematic-content-tree
        question-content-tree chunks tagged-chunk clause keys specific-answers
        unbidden-answers thematic-answer question facts gist-clauses)
      ;
      ; Form specific answer clauses from input
      ; ```````````````````````````````````````
      ; Form successive 10-word chunks of 'words', stepping forward
      ; 5 words at a time. But include immediately preceding negative
      ; words at the beginning of chunks. (If 'words' is 15 words or 
      ; less, use a single 15-word chunk.)
      ;(format t "~% prior-gist-clause =" prior-gist-clause)
      (setq tagged-prior-gist-clause 
            (mapcar #'tagword prior-gist-clause))
      ;(format t "~% tagged prior gist clause = ~a" tagged-prior-gist-clause)
      ; Find the (three) gist-clause extraction trees corresponding
      ; to 'tagged-prior-gist-clause':
      (setq relevant-trees 
            (cdr ; drop the :subtrees directive from the result
              (choose-result-for 
                tagged-prior-gist-clause '*gist-clause-trees-for-input*)))
      ; *********************** HERE ************************************
      ; there is a problem here
      ; for garbage plate the following clue is NIL, while it should be something like this
      ;  (SUBTREES *SPECIFIC-ANSWER-FROM-MAJOR-INPUT*
      ;              *UNBIDDEN-ANSWER-FROM-MAJOR-INPUT*
      ;              *THEMATIC-ANSWER-FROM-MAJOR-INPUT*
      ;              *QUESTION-FROM-MAJOR-INPUT*)

      ;(choose-result-for tagged-prior-gist-clause '*gist-clause-trees-for-input*)          
      ;(format t "~% this is a clue == ~a" (choose-result-for tagged-prior-gist-clause '*gist-clause-trees-for-input*))
      ;(format t "~% relevant trees = ~a" relevant-trees)          
      (setq specific-content-tree (first relevant-trees)
            unbidden-content-tree (second relevant-trees)
            thematic-content-tree (third relevant-trees)
            question-content-tree (fourth relevant-trees))

      (setq chunks (form-chunks words))
      ; (format t "~% chunks = ~a" chunks) 
      ; Apply the 'specific-content-tree' and the 'unbidden-content-tree'
      ; to each chunk, and collect any non-nil results, also storing
      ; them in *gist-kb* under the key that is returned along with
      ; any factual gist clause by the tree search (this will in 
      ; particular enable Lissa to tell later if a question about
      ; to be asked of the user has already been answered; also,
      ; in future we might generate inferences from gist clauses):
      (dolist (chunk chunks)
         (setq tagged-chunk (mapcar #'tagword chunk))
         (setq clause 
           (cdr ; drop the :gist directive
             (choose-result-for tagged-chunk specific-content-tree)))
         ; here the clause should be a gist but it is not (BBQ question)
         ;(format t "~% tagged-chunk = ~a" tagged-chunk)
         ;(format t "~% specific-content-tree = ~a" specific-content-tree) 
         ;(format t "~% before clause = ~a" (choose-result-for tagged-chunk specific-content-tree))
         ;(format t "~% clause = ~a" clause)
         (when clause ; this is of form (wordlist keys)
            (setq keys (second clause))
            (push (pop clause) specific-answers); save, w/o keys
            (store-fact clause keys *gist-kb*))

         (setq clause 
           (cdr ; drop the :gist directive
             (choose-result-for tagged-chunk unbidden-content-tree)))
         (when clause 
            (setq keys (second clause))
            (push (pop clause) unbidden-answers)
            (store-fact clause keys *gist-kb*)))
  
      (if specific-answers
          (setq specific-answers 
             (reverse (remove-duplicates specific-answers :test #'equal))))
             ; Lissa's reaction will depend especially on the first
             ; specific answer, which is likely to be the one most
             ; directly answering Lissa's question

      (if unbidden-answers
          (setq unbidden-answers
             (reverse (remove-duplicates unbidden-answers :test #'equal))))

      ; Form thematic answer from lengthy input
      ; ```````````````````````````````````````
      (if (> n 15)
          (setq thematic-answer
            (cdr ; drop the :gist directive
              (choose-result-for 
                 (mapcar #'tagword words) thematic-content-tree))))
      (when thematic-answer
         (setq keys (second thematic-answer))
         (setq thematic-answer (car thematic-answer))
         (store-fact thematic-answer keys *gist-kb*))

      ; Form final question from input
      ; ``````````````````````````````
      (if (> n 5)
          (setq question; use up to 12 final words of input
            (cdr ; drop the :gist directive
              (choose-result-for (mapcar #'tagword (last words 12)) 
                                     question-content-tree))))
      ; Note: questions by the user are currently not stored
      ; (though we could store the fact that the user asked them).
      
      ; The results obtained will be stored as the 'gist-clauses'
      ; property of the name of the user input. So, concatenate
      ; the above results; in reacting, Lissa will pay particular
      ; attention to the first clause, and any final question.
      (setq facts specific-answers)
      (if thematic-answer 
          (setq facts (append facts (list thematic-answer))))
      (setq gist-clauses facts)
      (if question
          (setq gist-clauses  (append facts (list question))))
	
	  ; Modified to allow arbitrary unexpected inputs to be processed. -PM
      (if (null gist-clauses)
	      (list words)
		  gist-clauses)
 )); end of form-gist-clauses-from-input


(defun form-chunks (words); tested Aug 10/15
;````````````````````````
; Given the list of words 'words', form 10-word chunks overlapping by
; 5 words; if there are just 15 words or less, form a single chunk,
; i.e., a singleton list containing the list of words. For non-initial
; chunks whose first word is preceded in 'words' by a negative word,  
; add that word to the beginning of the chunk (so that negatives
; won't be mistaken for positives).
;
 (let ((n (length words)) chunks chunk negword changed result)
      (cond ((< n 15) 
             (return-from form-chunks (list words))); 1 chunk only
            (t ; form multiple word chunks, 10 words long, 
               ; overlapping 5 words
               (loop
                  (setq n (- n 5))
                  (setq chunk (butlast words (- n 5)))
                  (setq words (last words n))
                  (push chunk chunks)
                  (when (<= n 10)
                        (push words chunks)
                        (return nil)))
               (setq chunks (reverse chunks))
               ; 'negword' copy-over:
               (dolist (chunk chunks)
;                 (format t "~%negword = ~a" negword); DEBUGGING
;                 (format t "~%  chunk = ~a" chunk); DEBUGGING
                  (when negword (push negword chunk)
                                (setq changed t))
                  (push chunk result)
                  (setq negword
                     (find (car (last chunk 6)); 6th word from end
                           '(no not don\'t cannot can\'t won\'t couldn\'t
                             wouldn\'t never hardly))))
               (if changed (reverse result) chunks)))
 )); end of form-chunks
 

(defun store-fact (fact keys kb); tested
;`````````````````````````````````
; put 'fact' into the 'kb' (a hash table) using the given keys.
; Avoid duplication of already stored facts. This is intended 
; primarily for acquired facts (as gist clauses) about the user,
; but should also be usable for facts about Lissa, that Lissa
; could consult in answering questions from the user.
;
 (let ((facts (gethash keys kb)))
      (if (not (member fact facts :test #'equal))
          (setf (gethash keys kb) (cons fact facts)))
 )); end of store-fact


(defun ttt-non-initial-var? (x); June 25/15
;``````````````````````````````
; Is x a TTT match variable starting with '_'?
 (let (chars)
      (cond ((not (symbolp x)) nil)
            (t (setq chars (explode x))
               (and (char-equal (car chars) #\_)
                    (find (second chars)
                            '(#\! #\? #\+ #\*) :test 'char-equal))) )
 )); end of ttt-non-initial-var? 
             

(defun ttt-initial-var? (x); June 25/15
;```````````````````````````
; Is x a TTT match variable starting with on of {! ? + * ^}
; or with <> or {}?
 (let (chars)
      (cond ((not (symbolp x)) nil)
            (t (setq chars (explode x))
               (or (find (car chars)
                    '(#\! #\? #\+ #\* #\^) :test 'char-equal)
                   (and (char-equal (car chars) #\<)
                        (char-equal (second chars) #\>))
                   (and (char-equal (car chars) #\{)
                        (char-equal (second chars) #\})) )) )
 )); end of ttt-initial-var?


(defun ttt-match-vars (patt); June 25/15
; ``````````````````````````
; Form a list of distinct TTT match-variables that occur in 'patt';
; Duplicate variables that occur earlier in a left-to-right scan are
; discarded.
 (prog (var vars)
      ; Find the match variables occurring in 'patt':
      (if (symbolp patt) 
          (if (ttt-non-initial-var? patt)
              (return `(,patt)); top-level match variable -- return as list
              (return nil)))
            
      ; It's a list; check for initial match variable (save as 'var')
      (if (and (listp patt) 
               (symbolp (car patt)) (ttt-initial-var? (car patt)))
          (setq var (car patt)) )
      ; Append the results of mapping 'ttt-match-vars onto (cdr patt)
      (setq vars (apply #'append 
                        (mapcar #'ttt-match-vars (cdr patt))))
      ; Add var as initial element, if it is non-nil
      (if var (push var vars))
      (return (remove-duplicates vars))
 )); end of ttt-match-vars
 

(defun bindings-from-ttt-match (patt expr); June 25/15
; ````````````````````````````````````````
; From the TTT pattern 'patt', create a rule that generates the
; binding list for the match variables of 'expr', when matched
; to that expression. Apply the rule to 'expr', hence obtain
; a lsit of bindings. A non-sticky match is assumed.
 (let ((vars (ttt-match-vars patt)) vals)
      (if (null vars) (return-from bindings-from-ttt-match nil))
      (setq vals (ttt:apply-rule `(/ ,patt ,vars) expr))
      ; For rules that don't match a given expr, 'ttt:apply-rule' 
      ; returns a result 'eq' to the expr.  Since that's a failure 
      ; case, return nil for it:
      (if (eq vals expr) (return-from bindings-from-ttt-match nil))
      ; Otherwise return the variables matched with their values:
      (mapcar #'list vars vals)
 )); end of bindings-from-ttt-match


;; A couple of Common Lisp hacks needed to implement MTS lisp functions

(defun explode (s)
;`````````````````
"the list of the characters making up symbol s"
 (coerce (string s) 'list))


(defun implode(l)
  "(IMPLODE LIST-OF-CHARACTERS) => a symbol
The symbol is interned in the current package and has as name a string 
with the characters in LIST-OF-CHARACTERS."
  (intern  (coerce l 'string)))


(defun say-words (wordlist); Sep 3/15; NB: there's a PRINT-WORDS fcn too
;```````````````````````````
; This is intended for th *live* = T mode of operation, i.e., I/O
; is via the virtual agent; (but the output is printed as well).
; For terminal mode only, we use 'print-words'.
;
 (format t "~% ... "); initial dots distinguish Lissa outputs
 (setq *lissa-count* (+ *lissa-count* 1))
 (with-open-file (outfile "./output.txt" :direction :output :if-exists 
                                :append :if-does-not-exist :create) 
                 (format outfile "~%#~D: " *lissa-count*))
 (dolist (word wordlist) 
         (format t "~a " word)
         (with-open-file (outfile "./output.txt" :direction :output :if-exists
                                       :append :if-does-not-exist :create) 
                         (format outfile "~a " word)) 
         (if (or (member word '(? ! \.))
                 (member (car (last (explode word))) '(#\? #\! #\.)))
             (format t "~%")))
 (format t "~%")
 
 ); end of say-words


(defun read-words () 
  ;; This is the input reader when LISSA is used with argument live =
  ;; nil (hence also *live* = nil), i.e., with terminal input rather
  ;; than live spoken input.
  ;;
  ;; Use read-line to obtain a character string, and coerce this into 
  ;; a character list. Then tokenize into a list of upper-case atoms, 
  ;; treating (i) any nonblank character following a blank, (ii) any non-
  ;; blank nonalphanumeric character other than #\', #\-, #\_ following
  ;; an alphanumeric character, and (iii) any alphanumeric character 
  ;; following a nonalphanumeric character other than #\', #\-, #\_, 
  ;; as the start of a new atom.
  (let ((chars (coerce (read-line) 'list)) prevch chlist chlists) 
       (if (null chars) (return-from read-words nil))
       ; Form a list of character sublists, each sublist to be made
       ; into an atom; (the list & sublists will at first be backward,
       ; and so have to be reversed before interning & output)
       (setq prevch #\Space)
       (dolist (ch chars)
          ; Do we have the start of a new word?
          (if (or (and (char-equal prevch #\Space) 
                       (not (char-equal ch #\Space)) )
                  (and (alphanumericp prevch)
                       (not (alphanumericp ch))
                       (not (member ch '(#\Space #\' #\- #\_) 
                                       :test #'char-equal )))
                  (and (not (alphanumericp prevch))
                       (not (member prevch '(#\' #\- #\_) 
                                           :test #'char-equal ))
                       (alphanumericp ch) ))
              ; if so, push the current chlist (if nonempty) onto 
              ; chlists, and start a new chlist containing ch
              (progn (if chlist (push (reverse chlist) chlists))
                     (setq chlist (list (char-upcase ch))) )
              ; if not, push ch (if nonblank) onto the current chlist
              (if (not (char-equal ch #\Space))
                  (push (char-upcase ch) chlist) ))
          (setq prevch ch) )
        
        ; Push the final chlist (if nonempty) onto chlists (in reverse)
        (if chlist (push (reverse chlist) chlists))
        ; Return the reverse of chlists, where each sublist has been
        ; interned into an atom
        (reverse (mapcar #'intern chlists))
 )); end of read-words



(defun hear-words () 
;````````````````````
; This waits until it can load a character sequence from "./input.lisp",
; which will set the value of *next-input*, and then processes *input*
; in the same way as the result of (read-line) is processed in direct
; terminal input mode.
  (progn
    (setq *next-input* nil)
    (while (not *next-input*)
      (sleep .5)
      (progn
        (load "./input.lisp")
        (if *next-input*
          (progn
            (format t "~a~%" *next-input*)
            (with-open-file (outfile "./input.lisp" :direction :output 
                  :if-exists :supersede :if-does-not-exist :create))))))
          
  (let ((chars (coerce *next-input* 'list)) prevch chlist chlists) 
       (if (null chars) (return-from read-spoken-words nil))
       ; Form a list of character sublists, each sublist to be made
       ; into an atom; (the list & sublists will at first be backward,
       ; and so have to be reversed before interning & output)
       (setq prevch #\Space)
       (dolist (ch chars)
          ; Do we have the start of a new word?
          (if (or (and (char-equal prevch #\Space) 
                       (not (char-equal ch #\Space)) )
                  (and (alphanumericp prevch)
                       (not (alphanumericp ch))
                       (not (member ch '(#\Space #\' #\- #\_) 
                                       :test #'char-equal )))
                  (and (not (alphanumericp prevch))
                       (not (member prevch '(#\' #\- #\_) 
                                           :test #'char-equal ))
                       (alphanumericp ch) ))
              ; if so, push the current chlist (if nonempty) onto 
              ; chlists, and start a new chlist containing ch
              (progn (if chlist (push (reverse chlist) chlists))
                     (setq chlist (list (char-upcase ch))) )
              ; if not, push ch (if nonblank) onto the current chlist
              (if (not (char-equal ch #\Space))
                  (push (char-upcase ch) chlist) ))
          (setq prevch ch) )
        
        ; Push the final chlist (if nonempty) onto chlists (in reverse)
        (if chlist (push (reverse chlist) chlists))
        ; Return the reverse of chlists, where each sublist has been
        ; interned into an atom
        (reverse (mapcar #'intern chlists))
 ))); end of hear-words
       


(DEFUN COPY1 (LIST) ; top-level copy of LIST
   (COND ((ATOM LIST) LIST)
	 (T (CONS (CAR LIST) (COPY1 (CDR LIST))))))

(DEFUN CONC1 (L1 L2) ; graft L2 onto top-level copy of L1
   ; Avoids unnecessary CONSing (unlike CONC)
   (nconc (copy1  L1)  L2) )


(DEFUN RESET (RULE) ; Reset TIME-LAST-USED to -100 in all
 ; reassembly rules dominated by RULE
 (COND ((NULL RULE) NIL)
       (T (RESET (GET RULE 'CHILDREN))
	  (RESET (GET RULE 'NEXT))
	  (COND ((GET RULE 'TIME-LAST-USED)
		 (setf (get RULE 'TIME-LAST-USED) -100) )))))


(DEFUN DECOMPRESS (INPUT)
 ; replace contractions (e.g., DON'T or DONT by DO NOT)
  (COND ((NULL INPUT) NIL)
	((and (symbolp (car input)) (GET (CAR INPUT) 'TWOWORDS))
	 (CONC1 (GET (CAR INPUT) 'TWOWORDS) (CDR INPUT)) )
	(T (CONS (CAR INPUT) (DECOMPRESS (CDR INPUT)))) ))


(DEFUN COMPRESS (INPUT)
 ; replace auxiliary-NOT combinations by -N'T contractions
  (COND ((NULL INPUT) NIL)
	((NULL (CDR INPUT)) INPUT)
	(T (COND ((OR (NOT (EQ (CADR INPUT) 'NOT))
		      (NULL (GET (CAR INPUT) 'NEG)) )
		  (CONS (CAR INPUT)
		   (COMPRESS (CDR INPUT)) ))
		 (T (CONS (GET (CAR INPUT) 'NEG)
		     (COMPRESS (CDDR INPUT)) ))))))


(defun tagword (word); rewritten to avoid recursive run-away Sep 6/15
;````````````````````
 ; Returns a list headed by WORD and followed by its features
 ; (tags). These features are obtained from the FEATS
 ; property of the word, from the FEATS property of the 
 ; features (usually further words) thus obtained, etc.

  (if (not (get word 'feats)) (return-from tagword (list word)))
  (let (words feats feat)
       (setq feats (get word 'feats)); nonempty
       (setq words (list word))
       (loop (setq feat (pop feats)); current word/feature
             (if (not (find feat words))
                 (push feat words))
             (setq feats (union (get feat 'feats) feats)); add feats of
                                                         ; current word
             (if (member feat feats); avoid a feature cycle
                 (setq feats (remove feat feats)))
             (if (null feats)
                 (return-from tagword (reverse words))))
 )); end of tagword
          

(DEFUN PRESUBST (RESPONSE)
 ; This function is applied to lissa's responses before 
 ; their "dual" is formed and printed out. It helps avoid 
 ; outputs like
 ;      WHY DO YOU SAY I ARE STUPID
 ; (as the dual of WHY DO I SAY YOU ARE STUPID), while
 ; still correctly producing
 ;      WHY DO YOU SAY YOUR BROTHERS ARE STUPID
 ; (as the dual of WHY DO I SAY YOUR BROTHERS ARE STUPID).
 ;
 ; It replaces ARE by ARE2 when preceded by YOU (In turn, DUAL
 ; will replace YOU by I and ARE2 by AM, so that YOU ARE
 ; becomes I AM (whereas WE ARE, THEY ARE, etc., remain
 ; unchanged). Similarly it replaces YOU by YOU2 when it is
 ; the last word, or when it is not one of the first two
 ; words and is not preceded by certain conjunctions (AND,
 ; OR, BUT, THAT, BECAUSE, IF, WHEN, THEN, WHY, ...) or
 ; by certain subordinating verbs (THINK, BELIEVE, KNOW,...)
 ; This is in preparation for replacement of YOU2 by ME
 ; (rather than I) when DUAL is applied. This could be
 ; done in a more sophisticated way by using MATCH! 
 ; WAS -> WAS2 (after I) and WERE -> WERE2 (after YOU)
 ; have not been implemented.
  (COND ((NULL RESPONSE) NIL)
	; after the initial call, if the input is more than
	; one word, a number = max(1, no. of words processed)
	; is maintained as CDR of RESPONSE, while the actual
	; remainder of the response is in CAR RESPONSE
	((NULL (CDR RESPONSE))
	 (COND ((MEMBER (CAR RESPONSE) '(YOU YOU\. YOU! YOU?)) 
		'(YOU2) )
	       (T RESPONSE) ))
	((NUMBERP (CDR RESPONSE))
	 (COND ((NULL (CAR RESPONSE)) NIL)
	       ((NULL (CDAR RESPONSE)) (PRESUBST (CAR RESPONSE)))
	       (T; RESPONSE has a 0 or 1 flag as CDR, and the CAR
		 ; contains at least two words
		(COND ((AND (EQ (CAAR RESPONSE) 'YOU) 
			    (EQ (CADAR RESPONSE) 'ARE) )
		       (CONS 'YOU
			(CONS 'ARE2
			 (PRESUBST (CONS (CDDAR RESPONSE) 1)) )))
		      ((= 0 (CDR RESPONSE))
		       (CONS (CAAR RESPONSE)
			 (PRESUBST (CONS (CDAR RESPONSE) 1)) ))
		      ;
		      (T ; at least 1 word has been processed, i.e.
			 ;CDR is 1, & there are 2 or more words left
		       (COND ((OR (NOT (EQ (CADAR RESPONSE) 'YOU))
				  (AND (CDDAR RESPONSE)
				       (EQ (CADDAR RESPONSE) 'ARE) )
				  (MEMBER (CAAR RESPONSE)
				   '(AND OR BUT THAT BECAUSE IF SO
				     WHEN THEN WHY THINK SEE GUESS
				     BELIEVE HOPE THAN KNOW I YOU - --))
                                  (MEMBER           ; added Aug 29/02
                                     (CAR (LAST (COERCE (STRING (CAAR RESPONSE))
                                                       'LIST)))
                                    '(#\, #\. #\; #\! #\? #\:)
                                     :test #'char-equal))
			      (CONS (CAAR RESPONSE)
				    (PRESUBST
				       (CONS (CDAR RESPONSE) 1) )))
			     (T ; YOU (second el. of CAR RESPONSE)
				; to be replaced by YOU2
			      (CONS (CAAR RESPONSE)
			       (CONS 'YOU2
				(PRESUBST
				 (CONS (CDDAR RESPONSE) 1) )))) )))
	))     )
	(T; (CDR RESPONSE) is non-numeric, so that this is the
	  ; first call, with RESPONSE containing 2 or more words
	 (PRESUBST (CONS RESPONSE 0)) )
 )) ; end of PRESUBST


(DEFUN DUAL (SENTENCE)
   ; Replace I by YOU, YOU by I, MY by YOUR, YOUR by MY, etc.
   (COND ((NULL SENTENCE) NIL)
	 ((NULL (GET (CAR SENTENCE) 'SUBST))
	  (CONS (CAR SENTENCE) (DUAL (CDR SENTENCE))) )
	 (T (CONS (GET (CAR SENTENCE) 'SUBST)
		  (DUAL (CDR SENTENCE)) )) )); end of DUAL

(DEFUN DUALS (WORD1 WORD2)
   (PROGN (setf (get WORD1 'SUBST) WORD2) 
          (setf (get WORD2 'SUBST) WORD1) ))


(defun print-words (wordlist); revised version Sep 3/15
;````````````````````````````
; This is intended for the keyboard-based mode of interaction,
; i.e., with *live* = nil.
;
 (format t "~%...")
 (dolist (word wordlist)
    (princ " ")
    (princ word)
    (if (or (member word '(? ! \.))
            (member (car (last (explode word))) '(#\? #\! #\.)))
        (format t "~%")))
;(format t "~%")
 ) ; end of print-words


(DEFUN MATCH (PATTERN INPUT)
  ; Match decomposition pattern PATTERN against context-embedded,
  ; tagged input utterance INPUT. PATTERN is a list consisting of
  ; particular words or features (tags), NIL elements (meaning
  ; "exactly one word"), and numbers 0 (meaning "0 or more words"),
  ; 1, 2, 3, ... (interpreted as upper bounds on the number of
  ; words). In addition, the first element of a pattern may be "-",
  ; meaning that the INPUT should NOT match the remainder of the
  ; pattern. The output, if successful (non-NIL), is a list of
  ; parts of the input, one for each word, tag, NIL element, and 
  ; numerical element of the pattern. A "part" is just a list
  ; of words that actually occurred in the sentence, where
  ; these words are initial elements of tag-lists in INPUT.
  ; For "negative" patterns headed by "-", the output in case of
  ; success (i.e., remainder of pattern NOT matched) is a list
  ; containing the list of actual input words.
  ;
  (PROG (RESULT) 
	(COND ((NULL PATTERN) (RETURN NIL)))
	(COND ((EQ (CAR PATTERN) '-)
	       (SETQ RESULT (MATCH (CDR PATTERN) INPUT))
	       (COND (RESULT (RETURN NIL))
		     (T (RETURN (LIST (MAPCAR 'CAR INPUT)))) )))
	(COND ((NULL INPUT)
	       (COND ((AND (NULL (CDR PATTERN))
			   (NUMBERP (CAR PATTERN)) )
		      (RETURN '(())) )
		     (T (RETURN NIL)) )))

	(COND ((equal 0 (CAR PATTERN)) ; PATTERN starts with 0
	       (COND ((NULL (CDR PATTERN)) ; 0 only
		      (RETURN (LIST (MAPCAR 'CAR INPUT))) )
		     (T ; there's more after the 0
		      (SETQ RESULT (MATCH (CDR PATTERN) INPUT))
		      (COND (RESULT (RETURN (CONS NIL RESULT)))
			    (T ; matching 0 to null sequence failed
			     (SETQ RESULT (MATCH PATTERN
						 (CDR INPUT) ))
			     (COND (RESULT ; PATTERN (with initial
					   ; 0) matches (CDR INPUT)
				    (RETURN
				     (CONS (CONS (CAAR INPUT)
						 (CAR RESULT) )
					   (CDR RESULT) )))
				   (T (RETURN NIL)) ))))))

	      ((EQUAL (CAR PATTERN) 1) ; matches at most one word
	       (COND ((NULL (CDR PATTERN))
		      (COND ((NULL INPUT) (RETURN '(()))))
		      (COND ((NULL (CDR INPUT)) 
			     (RETURN (LIST (LIST (CAAR INPUT)))) ))
		      (RETURN NIL) ))
	       (SETQ RESULT (MATCH (CDR PATTERN) INPUT))
	       (COND (RESULT (RETURN (CONS NIL RESULT)))
		     (T ; matching 1 to null sequence failed
		      (SETQ RESULT (MATCH (CDR PATTERN)(CDR INPUT)))
		      (COND (RESULT (RETURN
				     (CONS (LIST (CAAR INPUT))
					   RESULT)))
			    (T (RETURN NIL)) ))))

	      ((NUMBERP (CAR PATTERN))
	       ; Note - the case where there is only a number
	       ; and INPUT is NIL was taken care of initially
	       (SETQ RESULT (MATCH (CDR PATTERN) INPUT))
	       (COND (RESULT (RETURN (CONS NIL RESULT)))
		     (T ; matching number to empty sequence failed
		      (SETQ RESULT (MATCH (CONS (-  (CAR PATTERN) 1)
						(CDR PATTERN) )
					  (CDR INPUT) ))
		      (COND (RESULT ; PATTERN with initial number
				    ; down by 1 matched (CDR INPUT)
			     (RETURN
			      (CONS (CONS (CAAR INPUT) (CAR RESULT))
				    (CDR RESULT) )))
			    (T (RETURN NIL)) ))))

	      ((NULL (CAR PATTERN)) ; NIL matches any word
	       (COND ((NOT (OR (CDR PATTERN) (CDR INPUT)))
		      (RETURN (LIST (LIST (CAAR INPUT)))) ))
	       (SETQ RESULT (MATCH (CDR PATTERN) (CDR INPUT) ))
	       (COND (RESULT
		      (RETURN (CONS (LIST (CAAR INPUT)) RESULT)) )
		     (T (RETURN NIL)) ))

	      (T ; first element of PATTERN is a word or feature
		 ; (tag) which should be present in the 1st element
		 ; of INPUT
		(COND ((NOT (MEMBER (CAR PATTERN) (CAR INPUT)))
		       (RETURN NIL) ))
		(COND ((NOT (OR (CDR PATTERN) (CDR INPUT)))
		       (RETURN (LIST (LIST (CAAR INPUT)))) ))
		(SETQ RESULT (MATCH (CDR PATTERN) (CDR INPUT)))
		(COND (RESULT
		       (RETURN (CONS (LIST (CAAR INPUT)) RESULT)) ) 
		      (T (RETURN NIL)) )))
 )) ; end of MATCH

;; REPLACED BELOW
(DEFUN INSTANCE (PATTERN PARTS)
 ; Substitute the words in the ith sublist of PARTS
 ; for any occurrences of i in PATTERN
  (COND ((NULL PATTERN) NIL)
	((NUMBERP (CAR PATTERN)) 
         ; the following line is changed from the mts code
         ; \(conc1 (car (nth parts (car pattern)))
         ; nth and nthcdr react differently to negative numbers

         (setq negtest (< (car pattern) 1))
	 (CONC1 (CAR (nthcdr (if negtest (- (length parts)  1) 
                                         (- (CAR PATTERN) 1) ) 
                             parts))  
		(INSTANCE (CDR PATTERN) PARTS) ))
	(T (CONS (CAR PATTERN) (INSTANCE (CDR PATTERN) PARTS))) ))

;; New version, Aug 24/15:
(DEFUN INSTANCE (PATTERN PARTS); briefly tested -- need to make sure
                               ; the use of concatenation doesn't mess
                               ; things up for nested structures!
 ; Substitute the words in the ith sublist of PARTS
 ; for any occurrences of i in PATTERN
  (COND ((NULL PATTERN) NIL)
	((NUMBERP (CAR PATTERN)) 
         ; the following line is changed from the mts code
         ; \(conc1 (car (nth parts (car pattern)))
         ; nth and nthcdr react differently to negative numbers

         (setq negtest (< (car pattern) 1))
	 (CONC1 (CAR (nthcdr (if negtest (- (length parts)  1) 
                                         (- (CAR PATTERN) 1) ) 
                             parts))  
		(INSTANCE (CDR PATTERN) PARTS) ))
        ((atom (car pattern))
         (CONS (CAR PATTERN) (INSTANCE (CDR PATTERN) PARTS)))
	(T (CONS (instance (CAR PATTERN) parts) 
                 (INSTANCE (CDR PATTERN) PARTS))) ))



(DEFUN ATTACHFEAT (LIST)
 ; Add the first element of LIST to the FEATS list
 ; of each remaining element
  (MAPC 
    (LIST 'LAMBDA '(X) 
       (LIST 'setf (list 'get  'X ''FEATS) 
	  (LIST 'CONS (LIST 'QUOTE (CAR LIST)) '(GET X 'FEATS)) ))
    (CDR LIST) ))


(DEFUN READRULES (rootname packet); modified June 26/15; 
;`````````````````````````````````  revised July 14,18/15
 ; This reads in the set of decomposition and output rules. 
 ; It embeds these rules in a tree whose root node is 'rootname',
 ; and where first children are reached via the 'children' property,
 ; and children are connected via the 'next' property. Rule node
 ; names are generated by GENSYM. Decomposition and output patterns
 ; are stored under the 'pattern' property, and output rules are
 ; distinguished by having a non-NIL 'directive' property.
 ;
 ; READRULES also puts a numerical property called 'latency' 
 ; on the property list of output rules. This is the number
 ; of outputs that must be generated before the rule can be
 ; used again. As indicated below, in the data set the numeric
 ; value of latency and the directive symbol are supplied jointly
 ; as a 2-element list, but these become separate properties
 ; in the choice tree that is built.
 ;
 ; 'Packet' is of form (depth pattern optional-pair
 ;	                depth pattern optional-pair ...)
 ; where "depth" is a number =1 for top-level rules, =2 for
 ; direct descendants of top-level rules, etc.; "pattern" is
 ; a decomposition pattern or other output; and optional-pair
 ; is present iff "pattern" is a reassembly pattern or other 
 ; output. The first element of optional-pair, if present, is 
 ; the latency of the rule. The second element (the directive
 ; symbol) is :out (for reassembly), :subtree (for continuing
 ; recursion in a subtree), :subtrees (for a list of subtrees
 ; to be returned as output), :subtree+clause (for a recursive
 ; continuation where a choice tree root plus a clause constructed
 ; by a reassembly rule are used), :schema (when the output is
 ; the name of a schema), :schema+args (when the schema name is 
 ; accompanied by an argument list whose elements depend on
 ; reassembly), and :gist (when the output is a decontextualized
 ; user sentence -- a "gist clause").
 ;
  (PROG (STACK REST N NAME)
	(setf (get rootname 'PATTERN) (CADR packet))
	(SETQ STACK `((1 . ,rootname))); the root is at depth (level) 1;
                                      ; Its NEXT or CHILDREN properties will
                                      ; be set if/when a rule at the same
                                      ; or a lower depth is encountered
	(SETQ REST (CDDR packet)); advance past the 1st depth-# and pattern
   NEXT (COND ((NULL REST) (RETURN "RULE TREE HAS BEEN BUILT")))
	(SETQ N (CAR REST)); save next depth number, or optional pair)
	(SETQ REST (CDR REST)) ; advance past depth number to next pattern,
                               ; or past the optional pair to the next
                               ; depth number
	(COND ((NUMBERP N); if N is a number, it is the depth of a new rule
	       (SETQ NAME (GENSYM "RULE"))
;              (format t "~%New rule ~a " name); DEBUGGING
	       (setf (get NAME 'PATTERN) (CAR REST)); attach PATTERN to rule
;              (format t "~%'PATTERN' property of ~a is ~%  ~a" ; DEBUGGING
;                                      NAME (get NAME 'PATTERN)); DEBUGGING
	       (SETQ REST (CDR REST)); advance past the current pattern
	       (COND ((EQUAL N (CAAR STACK)); new rule at same depth?
                      ; let NEXT of previous rule point to new rule:
		      (setf (get (CDAR STACK) 'NEXT) NAME)
;                     (format t "~%@@ NEXT pointer of ~s has been ~
;                          set to ~s" (get (cdar stack) 'next) name); DEBUGGING
                               
                      ; the current level-n rule on the stack is no longer
                      ; needed -- replace it by the new level-n rule:
		      (RPLACA STACK (CONS N NAME)) )
		     ((> N (CAAR STACK)); is the new rule at greater depth?
                      ; let CHILDREN of previous rule point to new rule:
		      (setf (get (CDAR STACK) 'CHILDREN) NAME)
;                     (format t "~%@@ CHILDREN pointer of ~s has been ~
;                          set to ~s" (get (cdar stack) 'children) name); DEBUGGING
                      ; push new (level . rule name) pair onto the stack
                      ; (without any deletion from the stack):
		      (SETQ STACK (CONS (CONS N NAME) STACK)) )
		     (T ; new rule must be at higher level (lower depth)
		      (SETQ N (- (CAAR STACK) N)); depth differential
                      ; pop a number of stack elements = depth differential
		      (dotimes (dummyvar n) (setq stack (cdr stack)))
                      ; resulting top element must be at same depth, so
                      ; set its NEXT pointer to the new rule:
		      (setf (get (CDAR STACK) 'NEXT) NAME)
;                     (format t "~%@@ NEXT pointer of ~s has been ~
;                          set to ~s" (get (cdar stack) 'next) name); DEBUGGING
                      ; Replace the top stack element with the (depth . rule)
                      ; pair for the new rule:
		      (RPLACA STACK (CONS (CAAR STACK) NAME)) )))
	      (T ; N is a (latency directive) pair, rather than depth number;
               ; set the latency of the rule at the top of the stack to
               ; the value given as car of the pair
	       (SETF (GET  (CDAR STACK) 'LATENCY) (CAR N))
;              (format t "~%'LATENCY' property of ~a is ~%  ~a" ; DEBUGGING
;                     (CDAR STACK) (GET  (CDAR STACK) 'LATENCY)); DEBUGGING
               ; TIME-LAST-USED value should be more negative than any
               ; latency so that no rule will be blocked intitially:
	       (SETF (GET  (CDAR STACK) 'TIME-LAST-USED) -10000)
               ; let the 'directive' property of the rule be the second
               ; element of the pair:
	       (SETF (GET (CDAR STACK) 'directive) (second N)) 
;              (format t "~%'DIRECTIVE' property of ~a is ~%  ~a" ; DEBUGGING
;                      (CDAR STACK) (GET (CDAR STACK) 'directive)); DEBUGGING
              ))
	(GO NEXT)
 )) ; end of READRULES

;;;; End of lissa5.lisp

