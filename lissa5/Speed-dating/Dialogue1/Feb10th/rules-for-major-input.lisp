; "rules-for-major-input.lisp"
; ====================================================================

;; We start with choice packets for gist clause extraction from
;; the user's response to the "major" question, and then supply 
;; possible Lissa reactions to the extracted gist clauses. This
;; organization is intended to anticipate later division of 
;; processing into interpretation of inputs and formulating 
;; responses to inputs, based on interpreted inputs together 
;; with background knowledge.

;; The initial set of features are intended to support analysis
;; of, and hence reaction to, the user's answer to the major 
;; question. 

(eval-when (load eval)

  (MAPC 'ATTACHFEAT
        '(; New as of June 18/15:
          (academic-subject science humanities social-science medicine
                  engineering)
          (medicine medical clinical dentist dentistry dental hygiene pediatrics
                  doctor physician psychiatry specialist primary care neurology
                  nursing nurse surgery surgeon pharmacology obstetrics gynecology
                  therapeutics mental premed)
          (science computer physics chemistry optics biology biological
                  neuroscience molecular genetics biomedical biochemistry
                  botany bcs brain cognitive mathematics math mathematical
                  statistics earth environmental geography geology geological astronomy
                  astrophysics sci)
          (humanities formal-humanities language languages arts art theater
                  studio religion english slavic classics music film media
                  visual journalism bioethics comparative literature
                  cultures French German Japanese Russian Spanish)
          (formal-humanities philosophy linguistics)
          (social-science health history political business
                  history anthropology economics finance financial policy
                  psychology sociology education international)
          (engineering chemical mechanical industrial audio optical
                  civil electrical electronics)
          (major-first-words political environmental computer comp social
                  asian molecular engineering earth geological physical
                  computational public visual social cognitive)
          (major majoring majors)
          (minor minoring minors)
          (class classes)
          ))

;; The four choice packets for extracting gist clauses from the 
;; user's input concerning his/her major are aimed at (i) specific
;; answers contained in the input (or in 10-word chunks for lengthy 
;; inputs), (ii) thematic answers based on thematically repetitive 
;; inputs; (iii) unbidden answers extracted from user input, and 
;; (iv) questions at the end of inputs.
;;
;; N.B.: FOR (i) - (iii), I.E., THE DECLARATIVE GIST CLAUSES OBTAINED
;;       FROM THE USER'S RESPONSE TO A LISSA QUESTION, EACH OUTPUT
;;       FROM THE CORRESPONDING CHOICE PACKETS (DIRECTLY BELOW) MUST
;;       BE OF FORM (WORD-DIGIT-LIST KEY-LIST), E.G.,
;;           ((My major is 2 \.) (study-major)).
;;       BY CONTRAST, QUESTIONS OBTAINED FROM THE USER RESPONSES,
;;       AND LISSA REACTIONS TO USER RESPONSES, CURRENTLY CONSIST
;;       JUST OF A WORD-DIGIT LIST, WITHOUT A KEY LIST.
;;
;; Note that for purpose (i), if multiple answers are extracted
;; from successive chunks, they will be saved in the order of
;; occurrence, and the first answer will be considered the crucial
;; one (though thematic answers maybe be used instead of the first
;; answer if multiple majors falling under the same general theme 
;; are mentioned).

(READRULES '*specific-answer-from-major-input*

 '(1 (0 double major 2 academic-subject 2 academic-subject 0)
    2 ((My majors are 5 and 7 \.) (study-major)) (0 :gist)
   1 (I 4 academic-subject and 1 academic-subject 0)
    2 ((My majors are 3 and 6 \.) (study-major)) (0 :gist)
   1 (I 4 major-first-words academic-subject and 1 academic-subject 0)
    2 ((My majors are 3 4 and 7 \.) (study-major)) (0 :gist)
   1 (0 minor 2 academic-subject 0)
    2 ((My minor is 4 \.) (study-minor)) (0 :gist)
   1 (0 minor 2 major-first-words academic-subject 0)
    2 ((My minor is 4 5 \.) (study-minor)) (0 :gist)
   1 (4 major-first-words academic-subject 0)
    2 ((My major is 2 3 \.) (study-major)) (0 :gist)
   1 (I am 5 academic-subject 0)
    2 ((My major is 4 \.) (study-major)) (0 :gist)
   1 (I\'m 5 academic-subject 0)
    2 ((My major is 3 \.) (study-major)) (0 :gist)
   1 (I am 5 major-first-words academic-subject 0)
    2 ((My major is 4 5 \.) (study-major)) (0 :gist)
   1 (I\'m 5 major-first-words academic-subject 0)
    2 ((My major is 3 4 \.) (study-major)) (0 :gist)
   1 (3 academic-subject 2 major 0)
    2 ((My major is 2 \.) (study-major)) (0 :gist)
   1 (3 major-first-words academic-subject 2 major 0)
    2 ((My major is 2 3 \.) (study-major)) (0 :gist)
   1 (2 major 2 academic-subject 0)
    2 ((My major is 4 \.) (study-major)) (0 :gist)
   1 (2 major 2 major-first-words academic-subject 0)
    2 ((My major is 4 5 \.) (study-major)) (0 :gist)
   1 (3 major-first-words academic-subject 0)
    2 ((My major is 4 5 \.) (study-major)) (0 :gist)
   1 (4 academic-subject 0) 
    2 ((My major is 2 \.) (study-major)) (0 :gist)
   1 (3 NEG nil nil 3)
    2 ((I have not decided on a major \.) (study-major)) (0 :gist)
  ))

    
(READRULES '*thematic-answer-from-major-input*
 ; Note: gist extraction rules have 0 latency (there is no reason
 ;       to "pause" their use)
 
 '(1 (0 academic-subject 0 academic-subject 0 academic-subject 0)
    2 (0 science 0 science 0 science 0)
     3 ((I am interested in various sciences\, including 2 and 4 and 6 \.)
       (study-interests)) (0 :gist)
   1 (0 academic-subject 0 academic-subject 0)
    2 (0 science 0 science 0)
     3 ((I am interested in various sciences\, including 2 and 4 \.)
       (study-interests)) (0 :gist)
    2 (0 medicine 0 medicine 0 )
     3 ((I am interested in various medical subjects\, including 2 and 4 \.)
       (study-interests)) (0 :gist)
    2 (0 humanities 0 humanities 0 )
     3 (0 formal-humanities 0 formal-humanities 0)
      4 ((I am interested in various formal humanities\, including 2 and 4 \.)
        (study-interests)) (0 :gist)
     3 ((I am interested in various humanities\, including 2 and 4 \.)
       (study-interests)) (0 :gist)
    2 (0 social-science 0 social-science 0 )
     3 ((I am interested in various social sciences\, including 2 and 4 \.)
       (study-interests)) (0 :gist)
    2 (0 engineering 0 engineering 0 )
     3 ((I am interested in various engineering sciences\, including 2 and 4 \.)
       (study-interests)) (0 :gist)
    ; Eventually, we should allow here for non-college-students as
    ; well, e.g., high/middle/elementary school, working adults, etc.
  ))

(READRULES '*unbidden-answer-from-major-input*
; These rules are intended to detect related facts offered by the
; user that may preempt later Lissa questions. Thus they should be
; stored, BUT DON'T REQUIRE A LISSA REACTION (at least not urgently).
 '(1 (0 academic-subject 2 trouble 0)
    2 ((I find 2 hard \.) (study-major difficulty)) (0 :gist)
   1 (0 trouble 2 academic-subject 0)
    2 ((I find 4 hard \.) (study-major difficulty)) (0 :gist)
   1 (0 trouble 2 class 0)
    2 ((I have some tough classes \.) (study-major difficulty)) (0 :gist)
   1 (0 class 2 trouble 0)
    2 ((I have some tough classes \.) (study-major difficulty)) (0 :gist)
   1 (2 I 3 freshman 0)
    2 ((I am a freshman \.) (study-year)) (0 :gist)
   1 (2 I\'m 2 freshman 0)
    2 ((I am a freshman \.) (study-year)) (0 :gist)
   1 (2 I 3 sophomore 0)
    2 ((I am a sophomore \.) (study-year)) (0 :gist)
   1 (2 I\'m 2 sophomore 0)
    2 ((I am a sophomore \.) (study-year)) (0 :gist)
   1 (2 I 3 junior 0)
    2 ((I am a junior \.) (study-year)) (0 :gist)
   1 (2 I\'m 2 junior 0)
    2 ((I am a junior \.) (study-year)) (0 :gist)
   1 (2 I 3 senior 0)
    2 ((I am a senior \.) (study-year)) (0 :gist)
   1 (2 I\'m 2 senior 0)
    2 ((I am a senior \.) (study-year)) (0 :gist)
   1 (2 I 3 first year 0)
    2 ((I am a freshman \.) (study-year)) (0 :gist)
   1 (2 I 3 second year 0)
    2 ((I am a sophomore \.) (study-year)) (0 :gist)
   1 (2 I 3 third year 0)
    2 ((I am a junior \.) (study-year)) (0 :gist)
   1 (2 I 3 fourth year 0)
    2 ((I am a senior \.) (study-year)) (0 :gist)
   1 (2 I 3 my last year 0)
    2 ((I am a senior \.) (study-year)) (0 :gist)
 ))

(READRULES '*question-from-major-input*
 ; included for illustrative purposes, even though the user is
 ; unlikely to ask a question (especially a reciprocal one) after
 ; stating his/her year & major, since Lissa already supplied hers

 '(1 (0 you find 3 hard 0)
     ; e.g., Do you find {computer science, your course load} hard?
    2 (Do you find your major hard ?) (0 :gist)
   1 (0 wh_ year 2 you 0); users sometimes miss part of "Comp. Sci. senior"
    2 (What year of study are you in ?) (0 :gist)
   1 (0 wh_ about you 0); 
    2 (What is your major ?) (0 :gist)
   1 (0 what do you study 0); 
    2 (What is your major ?) (0 :gist)
   1 (0 what is your major 0); 
    2 (What is your major ?) (0 :gist)
 ))

;; Now we add the rules for reacting to the specific gist-clause
;; answer extracted from the user's response to the "major" question

(READRULES '*reaction-to-major-input* 
  ; This should handle the gist clause form of all types of responses to
  ; LISSA's "major" question, including reciprocal questions.
  ; The rules are much like those in "choose-reaction-to-major5.lisp",
  ; but exploit the expected gist clause form and allow for negation, etc.
  ;
 '(1 (0 My major is 0)
    2 (0 medicine 0)
     3 (Studies in the medical field look pretty tough to you)
       (100 :out)
    2 (0 humanities 0)
     3 (0 formal-humanities 0)
      4 (Oh\, you really like 2 as well!)
        (100 :out)
     3 (The humanities aren\'t your strong suit.)
       (100 :out)
    2 (0 science 0)
     3 (Well\, it looks like we\'re both scientifically minded\.)
       (100 :out)
    2 (0 social-science 0)
     3 (Sounds like I am interested in how the world and society work.)
       (100 :out)
    2 (0 engineering 0)
     3 (Sounds like I enjoy building things. You would if you could!)
       (100 :out)
    2 (OK\, sounds interesting.) ; couldn't classify the specific subject area
      (100 :out)
   1 (My majors are 3 and 3 \.)
    2 (Wow\, 4 and 6 is an interesting combination.)
      (100 :out)
    2 (Those majors make for a pretty heavy course load!)
      (100 :out)
   1 (0 I have not decided on a major); assuming this is the extracted gist clause!
    2 (Well\, what area generally interests me ?)
      (100 :out) ; LISSA's "favorite subject" question will follow; (seems ok)
   ; questions:
   1 (0 you find 3 hard ?)
     ; e.g., Do you find {computer science, your course load} hard?
    2 (Some of your major courses are tough\, but you mostly enjoy them.) 
      (0 :out)
   1 (0 nothing found 0)
   2 (Interesting!)
    (100 :out)
 ))


;; If more than one of the three rule packets for extracting gist
;; clauses from the user input yield non-NIL results, reactions
;; to these will be integrated via schemas.
;;
;; For example, the schema might combine a reaction X to a specific
;; user answer with a question Y at the end of the user answer in
;; the manner
;;    <very short answer to Y>; so, <reaction to X>
;; e.g., if the user said she was in biomedical engineering,
;; and asked whether Lissa found comp sci hard, we might get
;;    <Not really>; so, <Sounds like you enjoy building things>
;; Another schema might be
;;    <reaction to X>; concerning your question, <answer to Y>
;; e.g.,
;;    <Sounds like you enjoy building things>; concerning your
;;    question, <I don't find computer science very hard, at least
;;    not in the subjects I enjoy and apply myself to>

 )



