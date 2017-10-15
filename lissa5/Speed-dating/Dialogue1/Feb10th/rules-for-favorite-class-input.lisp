
; This is a start on features and choice packets for abstracting
; gist clauses from, and reacting to, the user's answer concerning 
; his/her favorite class
;
; NB: This preempts the previous "choose-reaction-to-favorite-class5.lisp"

(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '(; This is an attempt based on PM's listing of UR courses;
    ; Unfortunately, this is not sufficient to identify actual
    ; course titles in many cases; but it hardly seems worthwhile
    ; to have reactions for all specific courses ready!
    ;
    ; It would help to have preprocessed inputs to join common
    ; combinations, such as 'experimental_design' from 'experimental
    ; syntax', 'experimental therapeutics', etc.; or 'american_sign_
    ; language' vs. 'american literature', 'american moderns', 
    ; 'americal business practice', 'american culture', 'american
    ; revolution', etc.
    (anthropology anthropological)
    (african africa african-american)
    (business entrepreneur entrepreneurs entrepreneurship finance 
     financial accounting marketing markets securities management 
     managerial business)
    (cog-sci behavioral behavior cognitive vision cognition emotional
     development brain perception)
    (comp-sci programming optimization structures AI software HCI
     dialogue robot assistive computer computational bioinformatics
     database algorithm algorithms processing operating data machine
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

;; N.B.: FOR THE DECLARATIVE GIST CLAUSES OBTAINED FROM THE USER'S 
;;       RESPONSE TO A LISSA QUESTION, EACH OUTPUT FROM THE CORRESPONDING 
;;       CHOICE PACKETS (DIRECTLY BELOW) MUST BE OF FORM 
;;          (WORD-DIGIT-LIST KEY-LIST), E.G.,
;;          ((My favorite class was 2 3 \.) (favorite-class))
;;       BY CONTRAST, QUESTIONS OBTAINED FROM THE USER RESPONSES,
;;       AND LISSA REACTIONS TO USER RESPONSES, CURRENTLY CONSIST
;;       JUST OF A WORD-DIGIT LIST, WITHOUT A KEY LIST.

; phrases for gist extraction:

 (READRULES '*specific-answer-from-favorite-class-input*
 '(1 (0 not 4 favorite 0)
    2 ((I do not have a favorite course \.) (favorite-class)) (0 :gist)
   1 (0 academic-course academic-course 0); e.g., quantum mechanics
    2 ((My favorite class was 2 3 \.) (favorite-class)) (0 :gist)
   1 (0 academic-subject academic-course 0); for slightly better coverage
                                           ; of 2-word course names
    2 ((My favorite class was 2 3 \.) (favorite-class)) (0 :gist)
   1 (0 academic-course 0); e.g., microeconomics
    2 ((My favorite class was 2 \.) (favorite-class)) (0 :gist)
   1 (0 artificial intelligence 0)
    2 ((My favorite class was artificial intelligence \.) (favorite-class)) (0 :gist)
   1 (0 3 0)
    2 ((Nothing found for my favorite class \.) (favorite-class)) (0 :gist)
    ; The rule right above might end up being problematic
  
 ; TBC -- remains to be done properly: look at examples, figure out how
 ; to extract (My favorite class is <so and so> \.), (I do not have
 ; a favorite class \.), etc.
 ))

 (READRULES '*thematic-answer-from-favorite-class-input*
    '(1 (0 cog-sci 0)
        2 ((My favorite class was in cognitive science\.) (favorite-class)) (0 :gist)
      1 (0 comp-sci 0)
        2 ((My favorite class was in computer science\.) (favorite-class)) (0 :gist)
      1 (0 ece 0)
        2 ((My favorite class was in ECE\.) (favorite-class)) (0 :gist)
      1 (0 linguistics 0)
        2 ((My favorite class was in linguistics\.) (favorite-class)) (0 :gist)
      1 (0 media 0)
        2 ((My favorite class was in media\.) (favorite-class)) (0 :gist)
      1 (0 math 0)
        2 ((My favorite class was in math\.) (favorite-class)) (0 :gist)
      1 (0 neuroscience 0)
        2 ((My favorite class was in neuroscience\.) (favorite-class)) (0 :gist)
      1 (0 philosophy 0)
        2 ((My favorite class was in philosophy\.) (favorite-class)) (0 :gist)
      1 (0 psychology 0)
        2 ((My favorite class was in psychology\.) (favorite-class)) (0 :gist)
      1 (0 anthropology 0)
        2 ((My favorite class was in anthropology\.) (favorite-class)) (0 :gist)
      1 (0 film 0)
        2 ((My favorite class was in film\.) (favorite-class)) (0 :gist)
      1 (0 fine-art 0)
        2 ((My favorite class was in fine-art\.) (favorite-class)) (0 :gist)
      1 (0 music 0)
        2 ((My favorite class was in music\.) (favorite-class)) (0 :gist)
      1 (0 dance 0)
        2 ((My favorite class was in dance\.) (favorite-class)) (0 :gist)
      1 (0 theater 0)
        2 ((My favorite class was in theater\.) (favorite-class)) (0 :gist)
      1 (0 physics 0)
        2 ((My favorite class was in physics\.) (favorite-class)) (0 :gist)
      1 (0 medicine 0)
        2 ((My favorite class was in medicine\.) (favorite-class)) (0 :gist)
      1 (0 foreign-language 0)
        2 ((My favorite class was in foreign-language\.) (favorite-class)) (0 :gist)
      1 (0 geology 0)
        2 ((My favorite class was in geology\.) (favorite-class)) (0 :gist)
      1 (0 life-science 0)
        2 ((My favorite class was in life-science\.) (favorite-class)) (0 :gist)
      1 (0 economics 0)
        2 ((My favorite class was in economics\.) (favorite-class)) (0 :gist)
      1 (0 business 0)
        2 ((My favorite class was in business\.) (favorite-class)) (0 :gist)
      1 (0 education 0)
        2 ((My favorite class was in education\.) (favorite-class)) (0 :gist)
      1 (0 environment 0)
        2 ((My favorite class was in environment\.) (favorite-class)) (0 :gist)
      1 (0 history 0)
        2 ((My favorite class was in history\.) (favorite-class)) (0 :gist)
      1 (0 literature 0)
        2 ((My favorite class was in literature\.) (favorite-class)) (0 :gist)
      1 (0 politics 0)
        2 ((My favorite class was in politics\.) (favorite-class)) (0 :gist)
      1 (0 social-science 0)
        2 ((My favorite class was in social-science\.) (favorite-class)) (0 :gist)
      1 (0 religion 0)
        2 ((My favorite class was in religion\.) (favorite-class)) (0 :gist)
      ))

 (READRULES '*unbidden-answer-from-favorite-class-input*
    '(1 (0 NEG 0 hard 0)
       2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
      1 (0 NEG 0 easy 0)
       2 ((I did find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
      1 (0 hard 0)
        2 ((I did find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)
      1 (0 easy 0)
        2 ((I did not find my favorite class hard \.) (favorite-class difficulty)) (0 :gist)))

 (READRULES '*question-from-favorite-class-input* '())
 ; The issue of reciprocal questions isn't important here, since Lissa is going to
 ; state her favorite class right away. Of course, the user could ask other questions,
 ; such as "So you're also interested in biology? What about it?" that might evade
 ; our question-detecting rules. Our purpose in writing rules to detect questions is
 ; that there are common kinds of questions that we can predict and adequately respond
 ; to even with the minimal language processing ability we currently have. For this
 ; topic, the only such category is reciprocal questions, and these are addressed
 ; in Lissa's plan by default. -PM

 (READRULES '*reaction-to-favorite-class-input* 
 
 '(1 (my favorite class 1 4 \.)
    2 (0 special-interest-course 0)
     3 (0 cog-sci 0)
      4 (Cognitive science is very interesting to you too\.) 
        (100 :out)
     3 (0 artificial intelligence 0)
      4 (Oh\, that\'s great -- we have something in common \.)
        (100 :out); NB: can still follow with "My favorite class by far ..."
     3 (0 comp-sci 0); some other CSC class
      4 (You naturally like computer science too \.)
        (100 :out)
     3 (0 ece 0)
       4 (E\.C\.E is not far from your interests as well \.)
         (100 :out)
     3 (0 linguistics 0)
      4 (You find linguistics fascinating too \.)
        (100 :out)
     3 (0 media 0)
      4 (That\'s very apropos!)
        (100 :out)
     3 (0 math 0)
      4 (Good for you! That\'s not easy stuff!)
        (100 :out)
     3 (0 neuroscience 0)
      4 (Neuroscience might help make us all smarter one day!)
        (100 :out)
     3 (0 philosophy 0)
      4 (You suppose in philosophy I learn what\'s real and what isn\'t\.)
        (100 :out)
     3 (0 psychology 0)
      4 (So I am learning to understand and help people\, which is good\.)
        (100 :out)
     3 (0 anthropology 0)
      4 (That sounds nice\. You like humans too\.)
        (100 :out)
    2 (0 fun-subject 0)
     3 (0 fine-art 0)
      4 (It must be nice to be artistic\.)
        (100 :out)
     3 (0 theater 0)
      4 (That must be a lot of fun\, as long as I don\'t get stage fright!)
        (100 :out)
     3 (0); music and dance are left over
      4 (I must be a very musical person\.)
        (100 :out)
    2 (0 history 0)
     3 (There are so many facts and dates to remember in history!)
       (100 :out)
    2 (0 education 0)
     3 (The world certainly needs good educators\.)
       (100 :out)
    2 (0 challenging-subject 0)
     3 (That sound pretty challenging to you!)
       (100 :out)
    2 (0 business 0)
     3 (If I have a good head for business\, I will probably be wealthy 
       one day!) (100 :out)
    2 (0 literature 0)
     3 (So I am probably a big reader!)
       (100 :out)
    2 (my favorite class was 4 \.); pick out topic, for default answer.
     3 (5 sounds like a very interesting subject\.)
       (100 :out)
   1 (0 not have 3 favorite 0)
    2 (Well\, I seem to enjoy my area of study as a whole\, though\.)
      (100 :out)
   1 (0 nothing found 0)
     2 (Well\, I seem to enjoy my area of study as a whole\, though\.)
      (100 :out)
  ; Any others that should be added?? (Added one: anthropology -PM)
 )); end of *reaction-to-favorite-class-input*

); end of eval-when
