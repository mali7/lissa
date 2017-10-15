
; July 28/15;
; [Not yet used -- currently "gist clauses" are used instead of wffs]
; ==================================================================
; This is an initial trial pattern base for determinging from the user's
; response to the favorite-class question (a) what the favorite class
; is (as an EL wff), and (b) whether the user commented on its difficulty
; (so that the subsequent question can be deleted if necessay)

; We also provide features, supplementing the generic ones in
; "general-word-data.lisp", so that words used in the user's response
; to the favorite-class question will be accompanied in pattern matching 
; by more abstract categories. [Actually, it's clear that it would be
; good to still have, as part of the context, the knowledge of what
; the user's major is; then we could make answers major-specific, even
; if there are too many classes in all the majors to anticipate in the
; choice packet...]

(eval-when (load eval)

 
  ; TBC -- this adds to the ones in the corresponding choice packet
  (MAPC 'ATTACHFEAT
	'(; New as of June 18/15:
          (anthropology anthropological)
    (african africa african-american)
    (business entrepreneur entrepreneurs entrepreneurship finance 
     financial accounting marketing markets securities management 
     managerial business)
    (cog-sci behavioral behavior cognitive vision cognition emotional
     development brain perception)
    (comp-sci programming optimization structures AI software HCI
     dialogue robot assistive computer computational bioinformatics
     database algorithms processing operating data machine
     artificial intelligence); don't add 'machines'!
    (dance hip_hop hip hop)
    (experiments experimentation quantitative)
    (economics economic economy economies microeconomics macroeconomics)
    (education school schools students educational teaching literacy
     assessment classroom classrooms childhood learning secondary 
     pedagogy pedagogical leadership)
    (ece circuit circuits electronics electronic photonics signal)
    (environment climate energy)
    (film cinema cinematic cinematography)
    (fine-art fine film drawing painting printmaking photography studio
     landscapes art artistry arts artist artists sculpture)
    (foreign-language russian french spanish portugese chinese arabic
     italian japanese asl german hebrew greek polish); 'elementary'
     ; usually refers to beginner language courses -- but also music,
     ; education ,etc.
    (geology geophysics sensing tectonic tectonics geomorphology
     geochemistry geordynamics seismic sedimentary faults)
    (history historical war holocaust dictatorship)
    (life-science ecology evolution biology animal mammal evolutionary
     biochemical biochemistry anatomy anatomical genetic genetics
     gene paleontology)
    (linguistics linguistic semantic semantics syntax syntactic
     psycholinguistics phonetics phonology)
    (literature reading writing english story poetry narrative narratives
     compositional playwriting literary writers fiction tolkien texts
     novel discourse shakespeare intellectual debate eliot beckett drama)
    (math mathematics mathematical statistics probability linear number
     equations calculus geometry algebra algebraic topology topological
     geometry)
    (media network digital)
    (medicine health clinical care healthcare pharmacology nurse nursing
     epidemiology)
    (music strings violin viola cello drum drumming saxophone trombone 
     keyboard jazz musicianship rock conducting conductors chamber 
     brass guitar harp horn piano trumpet woodwinds ensemle orchestra 
     orchestral blues stones beatles opera tuba bassoon oboe euphonium 
     flute piccolo clarinet harpsichord improvisation vocal voice sonata 
     harmony recital accompanying accompaniment percussion)
    (neuroscience neurobiology neural neuropsychology neurochemical
     neuroethology neurological neurotoxicology neuroeconomics 
     neuroethics neuroengineering)
    (philosophy ethics bioethics metaphysics kant logic reasoning
     reality realities epistemology socrates plato)
    (physics relativity dynamics nuclear sound physics universe
     multiverse quantum mechanics condensed microstructures optics
     optical cosmic cosmology solar thermodynamics electricity materials
     astrophysics)
    (politics political policy congress marx)
    (psychology psychophysiology family counseling therapy behavior)
    (social-science justice organizational urban governance
     civilization culture cultural antisocial family society jewish
     ethnic ethnicity america slavery children future; 'american' is risky
     western african feminist utopia women women\'s lifespan indigenous
     law legal); 'law' and 'legal' mostly indicate social science, outside
     ; of law school; 'scientific' is risky, e.g., scientific writing
     ; 'self' removed
    (religion religions religious theism islam christianity judaism
     scripture redemption testament hindu hinduism mythology)
    (theater acting actor actors plays); 'performance' can be music or theater

    ; collect some features for responding:
    (special-interest-course cog-sci comp-sci ece linguistics media math
     neuroscience philosophy psychology anthropology)
    (fun-course media film fine-art music dance theater)
    (challenging-course math physics medicine foreign-language
     geology life-science economics)
    (academic-course special-interest-course fun-course challenging-course
     business experiments education environment history literature politics
     social-science religion)
	  ))


; Decomposition and wff-assembly rules comprising the rule tree:
; (Just for the user response to the favorite-class question by LISSA)
; extensions such as .n, .a are not yet attached yet, but are specified
; in a way that allows subsequent attchment in postprocessing, e.g.,
; (dentistry . n) should subsequently become dentistry.n
;
; NOTE: In these rules, 'me' and 'you' refer to Lissa and the user
;    respectively, while in choice packets this is reversed.

 (READRULES '*crucial-contents-favorite-class-answer* ; root of rule tree for
                                      ; interpreting the user's reply to
                                      ; the favorite-class question
                                      ; (available as the VALUE property of
                                      ; *reply-to-favorite-class-question*)
 
 '(1 (0 academic-subject 0)
    2 (0 primary care 0)
      (0 WFF (you have-as.v (favorite.a subject.n) (K (primary_care . n))))
    2 (0 ac-subj-modifier 0)
      (0 WFF (you have-as.v (favorite.a subject.n) (K ((2 . a) (studies . n)))))
    2 (0 engineering-modifier 0)
      (0 WFF (you have-as.v (favorite.a subject.n) (K ((2 . a) (engineering . n)))))
    2 (0 professional-goal 0)
      (0 WFF (you have-as.v (favorite.a subject.n) (Ka ((become . v) (2 . n)))))
    2 (0 academic-subject 0) ; {else}
      (0 WFF (you have-as.v (favorite.a subject.n) (K (2 . n)))))
  ; TBC -- this just returns one result, and also it's not called by the 
  ; plan interpreter; we need some separate way to call it, & to get multiple
  ; results.

 )

 )
