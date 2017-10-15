(defparameter *lissa-asd-schema*

'(Event-schema (((set of me you) have-lissa-dialog.v) ** ?e)

:Actions

?a1. (Me say-to.v you '(Hi\, My name is LISSA\. It\'s an acronym for Live Interactive Social Skills Assistant\. I may sound choppy\, but I am still able to have a conversation with you\. During the conversation\, the system will try its best to prompt you on your eye contact\, volume\, body movements\, and smiling\. Let\’s chat a bit\.))

?a2. (Me say-to.v you '(What is your name ?))

?a3. (You reply-to.v ?a2.)

?a5. (Me react-to.v ?a3.)

?a6. (Me say-to.v you '(Was it easy for you to get here ?))

?a7. (You reply-to.v ?a6.)

?a9. (Me react-to.v ?a7.)

?a10. (Me say-to.v you '(Did someone drive you ?))

?a11. (You reply-to.v ?a10.)

?a13. (Me react-to.v ?a11.)

?a14. (Me say-to.v you '(So how long have you lived in Rochester ?))

?a15. (You reply-to.v ?a14.)

?a17. (Me react-to.v ?a15.)

?a18. (Me say-to.v you '(What don\'t you like about the city?))

?a19. (You reply-to.v ?a18.)

?a21. (Me react-to.v ?a19.)

?a22. (Me say-to.v you '(Tell me about your free time\, do you like watching TV and movies\, or are you more of a book reader ?))

?a23. (You reply-to.v ?a22.)

?a25. (Me react-to.v ?a23.)

?a26. (Me say-to.v you '(Do you like school?))

?a27. (You reply-to.v ?a26.)

?a29. (Me react-to.v ?a27.)

?a30. (Me say-to.v you '(What\'s your favorite subject in school?))

?a31. (You reply-to.v ?a30.)

?a33. (Me react-to.v ?a31.)

?a34. (Me say-to.v you '(I think we need to finish for today\, but it has been great knowing you ! How about you look over the feedback\.))

))

(setf (get '*lissa-asd-schema* 'semantics) (make-hash-table))

(defun store-output-semantics (var wff schema-name) (setf (gethash var (get schema-name 'semantics)) wff))

(setf (get '*lissa-asd-schema* 'gist-clauses) (make-hash-table))

(defun store-output-gist-clauses (var clauses schema-name) (setf (gethash var (get schema-name 'gist-clauses)) clauses))

(mapcar #'(lambda (x) (store-output-gist-clauses (first x) (second x) '*lissa-asd-schema*))
 '((?a1. ((hello \.)))))


(setf (get '*lissa-asd-schema* 'topic-keys) (make-hash-table))

(defun store-topic-keys (var keys schema-name) (setf (gethash var (get schema-name 'topic-keys)) keys))

(mapcar #'(lambda (x)  (store-topic-keys (first x) (second x) '*lissa-asd-schema*)) '())
