(defparameter *not-like-school-schema*

'(Event-schema (((set of me you) have-lissa-dialog.v) ** ?e)

:Actions

?a1. (Me say-to.v you '(I\'m sorry to hear that you don\'t like school \.))

?a2. (Me say-to.v you '(What do you not like about school ?))

?a3. (You reply-to.v ?a2.)

?a5. (Me react-to.v ?a3.)

?a6. (Me say-to.v you '(Is there anyone bothering you in school ?))

?a7. (You reply-to.v ?a6.)

?a9. (Me react-to.v ?a7.)

))

(setf (get '*not-like-school-schema* 'semantics) (make-hash-table))

(defun store-output-semantics (var wff schema-name) (setf (gethash var (get schema-name 'semantics)) wff))

(setf (get '*not-like-school-schema* 'gist-clauses) (make-hash-table))

(defun store-output-gist-clauses (var clauses schema-name) (setf (gethash var (get schema-name 'gist-clauses)) clauses))

(mapcar #'(lambda (x) (store-output-gist-clauses (first x) (second x) '*not-like-school-schema*))
 '((?a2. ((what do you not like about school ?)))
   (?a5. ((is there anyone bothering you in school ?)))))


(setf (get '*not-like-school-schema* 'topic-keys) (make-hash-table))

(defun store-topic-keys (var keys schema-name) (setf (gethash var (get schema-name 'topic-keys)) keys))

(mapcar #'(lambda (x)  (store-topic-keys (first x) (second x) '*not-like-school-schema*)) '())

