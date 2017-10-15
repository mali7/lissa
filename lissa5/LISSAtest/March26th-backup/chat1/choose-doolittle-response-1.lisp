; This is the doolittle choice packet (decision tree) -- currently used
; as last stage of Lissa1 (just for fun, and for detecting good-bye). 
; It is derived from the rule part of data.lisp.
;
;    This provides generic rules for personal consultation. The numeric
;    indices in front of the rules indicate their depth in the tree. A
;    rule prefixed by index i is at level i in the tree (where the top-
;    level rules are at level 1). If it is immediately preceded by a
;    rule with index i-1, it will become that rule's SONS; otherwise
;    it will become the NEXT rule of the nearest preceding rule with 
;    index i.  (This notation is interpreted in READRULES by a simple
;    stack mechanism.) A rule may or may not be followed by a context.
;    If not, it is a decomposition pattern, while if a context is
;    given, it is a reassembly pattern. The first element of a context
;    is the latency of the reassembly pattern, i.e., how many inputs
;    need to be seen before the reassembly pattern can be reused.
;    The rest of the context contains a slot, indicated by NIL, where
;    the next user input is to be placed; it may also specify additional
;    specific words, or word sequences obtained from the current input
;    (and indicated numerically). These contexts are used to "pad" the
;    next user input, hopefully giving it more informative content
;    (see further comments below).
;
;    Decomposition patterns allow for specific words and features
;    (specified explicitly), word sequences of length 0 or more
;    (specified with a 0), arbitrary single words (specified with NIL),
;    and word sequences of length at most i (specified with number i),
;    where i > 0. The first element of a pattern may be "-", meaning 
;    that the INPUT should NOT match the remainder of the pattern.
;    The result of the match (when the elements after "-" are *not*
;    matched) is the list of words of the actual input.
;
;    Reassembly patterns use specific words along with numerical
;    indices corresponding to the parts (word sequences) of the input
;    matched by the decomposition pattern.
;
;    Concerning contexts: before a user's input is embedded in a 
;    context, a check is made whether the input is more than 2 words.
;    If yes, it is NOT embedded in the context, but just used as-is. 
;    The point is that we really want to expand an input only if it 
;    is excessively terse, e.g., "YES", "NO", "MY MOTHER", etc. If it 
;    is longer, embedding it in the context will probably give nonsense. 
;    E.g., if LISSA asks WHO ELSE IN YOUR FAMILY GIVES YOU A HARD TIME?
;    and saves context (NIL GIVES ME A HARD TIME), then if the user 
;    responds "MY MOTHER", the expanded input will be sensible, but 
;    if he/she responds "MY MOTHER NAGS ME TOO", it will be nonsensical 
;    (MY MOTHER NAGS ME TOO GIVES ME A HARD TIME). A trick that is used
;    here for yes-no questions is to insert ANS at the head of a context
;    (right after the NIL), so that it is possible to tell subsequently
;    where the actual user input ends and where the added material starts.
;    This won't lead to trouble (outputs containing "ANS") as long as
;    user inputs starting with yes/no are always captured first by 
;    the rules that check for ANS (and make sure it doesn't appear
;    in the output).
;
;    Three special context headers (after removal of the latency number)
;    are RESTART, STOR, and RETR. Rules with a RESTART context are not 
;    used directly to generate outputs. Instead, when LISSA gets 
;    back a response (from the RESPONSE function) accompanied by 
;    a RESTART context, it treats that response as a transformed input,
;    feeding it back into the RESPONSE generator. This can be used to
;    good effect to "throw away" parts of inputs. For example, one can
;    throw away an initial I THINK by putting in a decomposition rule
;    with pattern (I THINK 0) and a reassembly rule with pattern (3) 
;    and context (RESTART). More generally, RESTART rules can be used
;    to transform inputs to some form that LISSA can already handle,
;    thus obviating a lot of rule-writing. One place where this is handy
;    is in processing expanded inputs obtained by embedding a NO answer
;    in a context, such as NO ANS I AM OFTEN UNHAPPY (really meaning 
;    "I deny that I am often unhappy"); this might be transformed by 
;    a suitable RESTART rule to I AM NOT OFTEN UNHAPPY.
;
;    STOR and RETR rules are used respectively to store and retrieve 
;    responses in a *MEMORY* queue. I.e., when the RESPONSE function 
;    encounters a STOR rule, it appends the response it has instantiated
;    to the *MEMORY* queue (rather than returning it to LISSA), and
;    then  recursively tries to return a response from its NEXT brother.
;    When RESPONSE encounters a RETR rule, it checks whether *MEMORY* is 
;    non-empty, and if so, pops off its CAR, returning this as the 
;    response. (If *MEMORY* is empty, it recursively tries to return a
;    response from its NEXT brother.) These devices can be used, as in
;    ELIZA, to save up responses for "emergencies", allowing the 
;    conversation to be steered back to an earlier input (using 
;    a *MEMORY* output such as EARLIER I SAID THAT...).


(eval-when (load eval)

; Decomposition and reassembly rules comprising the rule tree:

 (READRULES '*doolittle-responses* ; root of this rule tree (June 26/15)

 '(1 (2 I 1 FINISHED)                   ; non-obvious termination requests
    2 (BYE) (0 RESTART)                 ; "BYE" (etc.) is handled in the main program
   1 (LET\'S FINISH 1)                  ; Note: "FINISH" is a feature
    2 (BYE) (0 RESTART)

   1 (0 FOREIGN 0)			; foreign language
    2 (YOU ARE SORRY\, YOU ONLY SPEAK ENGLISH) (7 NIL)
    2 (YOU TOLD ME\, YOU ONLY SPEAK ENGLISH) (7 NIL)
    2 (PLEASE SPEAK TO YOU IN ENGLISH) (7 NIL)
    2 (YOU SPEAK NO FOREIGN LANGUAGES) (7 NIL)

   1 (NIL NIL NIL 0 END-PUNC 0)         ; multiple input, 1st one > 2 words
    2 (1 2 3 4) (1 RESTART)             ; discard all but 1st input 
   1 (2 END-PUNC NIL 0)                 ; multiple input, 1st one < 3 words
    2 (4) (1 RESTART)                   ; discard 1st input & restart

   1 (NP_ NIL NIL 0)	; candidate for STORage: should start with NP
    2 (- 0 ANAPHOR 0)	; don't STORe anaphoric inputs
     3 (- YOU 0)	; don't STORe YOU-inputs
      4 (- YOUR 0)	; don't STORe YOUR-inputs
       ; Note that an input can match only one of the following
       ; 4 patterns, which "sort" inputs by length, preventing
       ; duplicate STORage of a single input 
       5 (NIL NIL NIL NIL NIL NIL 0) 
        6 (EARLIER I SAID THAT 1 2 3 4 5 6 7) 
          (3 STOR NIL 1 2 3 4 5 6 7)
       5 (NIL NIL NIL NIL NIL)	
        6 (LET\'S COME BACK TO MY ASSERTION THAT 1 2 3 4 5)
          (3 STOR NIL 1 2 3 4 5)
       5 (NIL NIL NIL NIL)
        6 (DOES THIS HAVE ANYTHING TO DO WITH THE FACT THAT 1 2 3 4 ?) 
          (19 STOR NIL IT IS RELATED TO THE FACT THAT 1 2 3 4)
       5 (NIL NIL NIL)
        6 (WHAT ABOUT MY EARLIER ASSERTION THAT 1 2 3) (3 STOR NIL)

; INSERT CHAT1 PATTERNS -- June 15/15, LKS
; The input will be (CHAT1-OPENING), i.e., just containing the context
; marker 'CHAT1-OPENING';
   1 (CHAT1-OPENING 0) 
    2 (you are an autonomous avatar and your behavior is driven by artificial intelligence\.
       You may sound choppy\, but you are still able to have a conversation with me \.
       You are here to help me practice talking about myself \, so we will have
       a conversation focused on me \. This will be more helpful if I give
       longer answers\. During the conversation\, the system will try its best 
       to prompt me on my eye contact\, volume\, body movements\, and smiling\.
       If the eye icon flashes red\, it means I can try making more eye contact\.
       If the smiley face flashes red\, perhaps I could try smiling more\.
       If the speaker icon flashes red\, then pay attention to my voice\. 
       I might need to speak up or I might need to quiet down\.
       If the shaking person icon flashes red\, then pay attention to my body\. 
       Can I be more animated? Is my posture okay?
       As I make these adjustments\, the icon will switch back to green\.
       Alright\, lets get to know each other more\. You are a senior comp sci 
       major\, how about me ?) (1000 CHAT1-OPENING NIL)
    2 (CHAT1-OPENING nil 0); at least one input word!
     3 (What was my favourite class so far?)
       (1000 CHAT1-OPENING nil)
    2 (CHAT1-OPENING 0 don\'t 2 have 2 favorite 0)
     3 (Well\, what\'s one class I liked?)
       (1000 CHAT1-OPENING nil)
    2 (Did I find it hard?) ; presumed actual favorite class (don\'t didn't match)
      (1000 CHAT1-OPENING nil)
    2 (CHAT1-OPENING 1 neg 0)
     3 (Good for me -- You guess I can easily learn what I enjoy\.
        You liked Artificial Intelligence! That was your favourite by far! Though
        obviously\, you are a little bit biased on the subject\. You really think
        the material is great and the prof is even better\.
        So how long have I lived here in Rochester?)
       (1000 CHAT1-ROCHESTER nil); bypass next pattern, by jumping to next theme
    2 (CHAT1-OPENING 0);
     3 (But obviously it was worth the effort to me \.
        You liked Artificial Intelligence! That was your favourite by far! Though 
        obviously\, you are a little bit biased on the subject\. You really think 
        the material is great and the prof is even better\.
        So how long have I lived here in Rochester?)
       (1000 CHAT1-ROCHESTER nil)
   1 (CHAT1-ROCHESTER 0)
    2 (Wow! That is longer than you have been anywhere\. So what do I like most 
      about this city?)
      (1000 CHAT1-ROCHESTER nil)
    2 (What don\'t I like about the city?)
      (1000 CHAT1-ROCHESTER nil)
    2 (Ugh\, yeah\, that would bother you too\. Is there anything I would change?)
      (1000 CHAT1-ROCHESTER nil)
    2 (You \'ve never heard of that\. Could I tell you more about it?)
      (1000 CHAT1-ROCHESTER nil)
    2 (If I can\'t tell\, you haven\'t seen much of the city at all\. 
      What would we do if I took you on a tour?)
      (1000 CHAT1-ROCHESTER nil)
    2 (One thing you always wonder about is good places to eat\. I might not think 
      it by looking at you \, but you think restaurants are just great\. You love 
      to watch people enjoy their food\. You also love the way that every place 
      has its own unique atmosphere\. It does not have to be fancy\, you also 
      love those dirty spoon\, hole in the wall restaurants that have a really 
      fun and cool vibe\. Could I tell you about my favorite place to eat here 
      in Rochester?)
      (1000 CHAT1-ROCHESTER nil)
    2 (And what is this whole garbage plate thing about?)
      (1000 CHAT1-ROCHESTER nil)
    2 (Tell you more about my free time\, do I like watching TV and movies\, 
      or am I more of a book reader?)
      (1000 nil); That's as far as I've copied the LISSA CHAT1 script

; To segue into the original doolittle mode, when all the above LISSA rules
; have been used and LISSA is restarted, supply one more 'CHAT1-OPENING' rule
   1 (CHAT1-OPENING)
    2 (Tell you about any problems I may have\, and you will try to help me \.)
      (19 nil)
   1 (STUPIDTHING 0) ; brief insult
    2 (THERE\'S NO POINT IN GETTING ABUSIVE) (19 NIL)
    2 (COME NOW\, LET\'S HEAR ABOUT MY PROBLEMS INSTEAD) (25 NIL)
    2 (NOW THAT IT\'S OFF MY CHEST\, LET\'S CONTINUE WITH MY PROBLEM)
      (25 NIL)
    2 (\(YAWN\) -- KEEP MY MIND ON MY PROBLEMS) (25 NIL)
    2 (AM I FINISHED WITH MY OUTBURSTS?)
      (19 NIL ANS I AM FINISHED); everything after the 19 NIL, including
                                ; ANS, will be tacked onto the user's reply 
    2 (IF I CONTINUE IN THIS WAY\, YOU ARE AFRAID THE SESSION
       IS OVER) (19 NIL)
    2 (BYE) (0 RESTART)         ; Feed "BYE" back to LISSA, ending session
   1 (YOU 0 STUPIDTHING 0)      ; handle as 1-word insult
    2 (3) (1 RESTART)          

   1 (WELL 0)                   ; strip off initial "WELL"
    2 (2) (0 RESTART)

   1 (YES 0)			; yes-answer
    2 (YES ANS 0)               ; ANS indicates beginning of attached material
     3 (YES ANS NIL NIL NIL 0) 
      4 (3 4 5 6) (2 RESTART)   ; drop YES ANS and restart
     3 (|HMM,| |THAT'S| A BIT SURPRISING) (19 NIL)
     3 (AM I SURE?) (19 NIL ANS 3)
    2 (YES NIL 0) 
     3 (2 3) (0 RESTART)
    2 (WHY IS THAT?) (19 NIL)
    2 (YOU SEE) (13 NIL)
    2 (|WELL,| PERHAPS |THAT'S| A GOOD THING) 
      (29 NIL ANS |IT'S| A GOOD THING)

   1 (1 TENTATIVE 1 ANS 0)             ; tentative yes-answer
    2 (3 ANS THEME-KEY NIL 0)          ; thematically marked answer
     3 (3 4 MAYBE 5) (0 RESTART) ; preface MAYBE to actual input, dropping ANS
    2 (- 2 THEME-KEY 0)                ; not thematically marked
     3 (1 TENTATIVE 1 ANS 0)
      4 (MAYBE 5) (0 RESTART)

   1 (NO 0)                    ; no-answer
    2 (NO ANS 0)
     3 (NO ANS 4 AUX 0)
      4 (3 4 NOT 5) (1 RESTART); add NOT to the saved info & restart
     3 (|IT'S| NOT THE CASE THAT 3) (0 RESTART)
    2 (NO NIL 0) ; no ANS present -- reponse was longer
     3 (2 3) (0 RESTART); drop the NO & restart
    2 (WHY NOT?) (5 NIL)
    2 (GIVE YOU2 A FULLER ANSWER\, PLEASE) 
      (7 NIL I |DON'T| WANT TO)
    2 (COME |ON,| TELL YOU2 MORE) (19 NIL I |WON'T|)

   1 (2 DOUBT 2 ANS 0)                 ; tentative no-answer
    2 (2 DOUBT 2 ANS THEME-KEY NIL 0)  ; thematically marked answer
     3 (5 ANS THEME-KEY NIL 4 AUX 0)   ; auxiliary in answer?
      4 (3 4 PROBABLY 5 6 NOT 7) (0 RESTART); add PROBABLY and NOT to saved
                                            ; answer and restart
     3 (5 ANS THEME-KEY NIL 0)         ; no auxiliary
      4 (3 4 I DON\'T THINK THAT 5) (0 RESTART)
    2 (0); no theme-key
     3 (5 ANS 4 AUX 0)
      4 (PROBABLY 3 4 NOT 5) (0 RESTART)
     3 (5 ANS 0) ; no auxiliary
      4 (I DON\'T THINK THAT 3) (0 RESTART)

   1 (2 ANS 0) ; expanded input which was expected to be YES or
               ; NO but turned out to be something else (so that
               ; the expanded answer contains an "ANS" not removed
               ; by the above YES and NO rules)
    2 (3) (0 RESTART)

   1 (BECAUSE 0)                ; because-answer
    2 (BECAUSE NIL 0)
     3 (2 3) (6 RESTART)
     3 (IS THAT THE REAL REASON ?) 
       (19 NIL ANS THAT IS THE REAL REASON)
     3 (ARE THERE ANY OTHER REASONS ?)
       (19 NIL ANS I HAVE OTHER REASONS)
   1 (CONJ NIL 0) ; initial AND, OR, or BUT
    2 (2 3) (1 RESTART)
   1 (AUX 0)             ; probable yes-no question (but possibly imperative)
    2 (AUX I 0)
     3 (AM I 0)
      4 (AM I 0 BADPRED 0)
       5 (YOU DOUBT IT - WHY SHOULD I BE?)
         (19 NIL)
      4 (AM I 0 GOODPRED 0)
       5 (QUITE POSSIBLY - WOULD I LIKE IT IF I WERE 3 4 5 ?)
         (19 NIL ANS I WISH I WERE 3 4 5)
      4 (|WHAT'S| MY OWN OPINION ON THAT?)
        (19 NIL)
      4 (IF I AM 3 |,| WOULD IT TROUBLE ME ?)
        (19 NIL ANS IT WOULD TROUBLE ME)
      4 (DO I THINK I AM 3 ?)
        (19 NIL ANS I DO THINK I AM 3)
     3 (WILL I 0)
      4 (PERHAPS - WHAT IF I 3 ?)
        (19 NIL)
      4 (I EXPECT I WILL 0 - |DON'T| I ?)
        (19 NIL ANS I MAY 0)
     3 (CAN I 0)
      4 (CAN I 0 YOU 0)
       5 (BY ALL MEANS)
         (19 NIL)
      4 (WHAT DO I SUPPOSE WOULD HAPPEN IF I 3 ?)
        (19 NIL)
     3 (SHOULD I 0)
      4 (DO I WANT TO ?)
        (9 NIL ANS I DO WANT TO 3)
     3 (DO I 0)
      4 (IN SOME WAYS I DO 0 - WHY DOES IT MATTER ?) 
        (29 NIL)
     3 (WHAT WOULD IT MEAN TO ME IF I 1 ?)
       (19 NIL)
     3 (LET\'S SUPPOSE I 1 - HOW WOULD YOU FEEL ABOUT THAT ?)
       (19 I WOULD FEEL NIL ABOUT IT)
     3 (IF I 1 |,| AM I WORRIED ABOUT IT?)
       (19 NIL ANS I DO WORRY) 
    2 (AUX YOU 0)
     3 (ARE YOU 0)
      4 (ARE YOU 2 BADPRED 0)
       5 (YOU |DON'T| THINK SO |.| WHY DO I ASK?)
         (19 NIL)
       5 (WOULD IT WORRY ME IF YOU WERE 3 4 5 ?)
         (19 NIL ANS THAT IS WORRISOME)
      4 (ARE YOU 2 GOODPRED 0)
       5 (YOU HOPE YOU ARE 3 4 5 |.| AM I ?)
         (19 NIL ANS I AM 3 4 5)
     3 (WILL YOU 0)
      4 (WILL YOU 0 GOODPRED 0)
       5 (YOU HOPE YOU WILL - HOW DO I REACT TO THAT ?)
         (29 NIL)
     3 (PERHAPS YOU 1 \. WHY DO I ASK?)
       (19 NIL)
     3 (IF YOU 1 |,| DOES IT REALLY MATTER?)
       (10 NIL)
     3 (|LET'S| TALK ABOUT ME INSTEAD)
       (5 NIL)
     3 (|WE'RE| CONCERNED WITH ME\, NOT YOU)
       (3 NIL)
     3 (NEVER MIND - LET\'S FIND OUT ABOUT MYSELF)
       (3 NIL)
     3 (WHY DO I ASK?)
       (2 NIL)
    2 (AUX NOT NP_ 0)
     3 (PERHAPS |NOT.| |IT'S| NOT TOO IMPORTANT) (19 NIL)
     3 (IF |NOT,| WHAT ABOUT THAT?) (19 NIL)
    2 (AUX NP_ 0)
     3 (IF |SO,| IS IT IMPORTANT TO ME ?) (19 NIL)
     3 (|LET'S| FIND OUT MORE ABOUT MY PROBLEM) (19 NIL)
    2 (DO NOT 0) ; probable negative imperative
     3 (YOU |DON'T| THINK YOU DO ANYWAY) (19 NIL)
     3 (WHY NOT?) (19 NIL)

   1 (WHY 0)                  ; why-question
    2 (WHY 2 I 0)
     3 (WHY NIL NOT I 0)
      4 (I 2 NOT 5) (4 RESTART)
      4 (DO I THINK I SHOULD 5 ?)
        (19 NIL ANS I SHOULD 5)
     3 (WHY NIL I 0)
      4 (I 2 4) (4 RESTART)
    2 (WHY 2 YOU 0)
     3 (WHY NIL NOT YOU 0)
      4 (WHY ARE NOT YOU 0)
       5 (YOU ARE NOT 5) (3 RESTART)
      4 (WHY HAVE NOT YOU 0)
       5 (YOU HAVE NOT 5) (3 RESTART)
      4 (|IT'S| NOT IMPORTANT THAT YOU 5)
        (19 NIL)
      4 (I 2 NOT 5) (4 RESTART)
     3 (WHY NIL YOU 0)
      4 (WHY DO YOU 0)
       5 (YOU 4) (3 RESTART)
      4 (YOU 2 4) (3 RESTART)
     3 (WE WERE TALKING ABOUT ME\, NOT YOU)
       (10 NIL)

   1 (HOW 0) ; how-question
    2 (HOW CAN YOU 0)
     3 (|IT'S| NOT IMPORTANT HOW |.| TELL YOU2 MORE ABOUT
       MY PROBLEM) (19 NIL)
     3 (DO I THINK YOU |SHOULDN'T| 4 ?)
       (15 NIL ANS YOU SHOULD NOT 4)
    2 (HOW CAN I 0)
     3 (|ISN'T| IT OBVIOUS HOW TO 4 ?)
       (19 NIL ANS I DO KNOW HOW TO 4)
     3 (DO I REALLY WANT TO 4 ?)
       (19 NIL ANS I DO WANT TO 4)
     3 (I JUST NEED TO REALIZE I CAN 4)
       (19 NIL)
    2 (HOW COULD I 0)
     3 (HOW CAN I 4) (0 RESTART)
    2 (HOW SHOULD I 0)
     3 (HOW CAN I 4) (0 RESTART)
    2 (HOW WILL I 0)
     3 (WHEN THE TIME COMES I WILL 4) (19 NIL)
     3 (AM I WORRIED THAT I WILL NOT 4) (19 NIL)
    2 (HOW WOULD YOU 0)
     3 (PERHAPS NOT LIKE YOU - BUT TELL YOU HOW I THINK I SHOULD 4)
       (19 NIL)
     3 (AM I CONCERNED THAT THE WAY I WOULD 4 IS INAPPROPRIATE ?)
       (19 NIL ANS I AM CONCERNED ABOUT THAT)
    2 (HOW WILL 0)
     3 (THAT IS |ANYONE'S| GUESS |.| |WHAT'S| MINE ?)
       (19 NIL)
     3 (PROBABLY NOT THE WAY I EXPECT |.| WHAT DO I EXPECT ?)
       (19 NIL)
    2 (HOW DO YOU 0)
     3 (HOW DO YOU DO)
      4 (FINE - AND I ?)
        (5 I AM NIL)
     3 (HOW DO YOU CONC 0)
      4 (PERHAPS YOU |DON'T| 4 5)
        (9 NIL)
     3 (MORE TO THE POINT\, HOW WOULD I 0)
       (19 NIL)
    2 (HOW DO I 0)
     3 (THERE ARE SURELY MANY WAYS\. |LET'S| HEAR MY SPECULATION)
       (29 NIL)
    2 (HOW AM I 0)
     3 (THAT WILL BECOME CLEAR\, YOU THINK)
       (19 NIL)
    2 (HOW FREQ 0)
     3 (HOW 2 |ISN'T| REALLY THE ISSUE) (19 NIL)
    2 (WHAT WOULD IT MEAN TO ME TO FIND OUT?)
      (9 IT WOULD MEAN NIL TO ME)
    2 (WHAT\'S MY GUESS?)
      (5 NIL)
    2 (THAT\'S HARD TO SAY\. I TELL YOU)
      (9 NIL)

   1 (1 WH_ 0) ; other wh-questions
    2 (1 WH_ 1 AUX NP_ 0)
     3 (WHAT IS THE MEANING OF LIFE)
      4 (I WANT TO KNOW THE MEANING OF LIFE) (19 STOR NIL)
      4 (LOOK AT IT AS AN OPPORTUNITY AND A CHALLENGE) (19  NIL)
     3 (0 AUX DET NIL 0 V 0)
      4 (PERHAPS 3 4 2 NOT 5 6 7) (19 NIL)
     3 (WHAT WOULD IT MEAN TO ME TO FIND OUT?) (19 NIL)
    2 (WHY DOES THAT INTEREST ME ?) (5 NIL)
    2 (WHAT DO I THINK IS A POSSIBLE ANSWER?)
      (5 NIL)
    2 (WHY?) (5 NIL)
    2 (YOU CANNOT ANSWER THAT RIGHT NOW)
      (5 NIL)
    2 (YOU DON\'T KNOW)
      (3 NIL)

   1 (2 SORRY 1) ; probable apology
    2 (PLEASE DON\'T APOLOGIZE) (7 NIL)
    2 (APOLOGIES ARE NOT NECESSARY) (7 NIL)
    2 (WHAT FEELINGS DO I HAVE WHEN I APOLOGIZE ?) (19 NIL)
    2 (YOU'VE TOLD ME THAT APOLOGIES ARE NOT REQUIRED) (7 NIL)

   1 (0) ; probable declarative
    2 (I 0)
     3 (I 1 CONC 0)
      4 (I 1 BELIEVE 0)
       5 (I DO NOT KNOW 0)
        6 (DO I HAVE ANY IDEA 5 ?) 
          (19 NIL)
        6 (WELL THEN\, TELL YOU2 SOMETHING I DO KNOW)
          (19 NIL)
       5 (I 1 BELIEVE 1 I 0 BADPRED 0)
        6 (DOES IT MAKE ME DEPRESSED TO THINK I 6 7 8 ?)
          (19 NIL ANS I AM DEPRESSED BY THAT)
       5 (I 1 BELIEVE 1 I AM NOT 2 GOODPRED 0)
        6 (DO I THINK IT IS IMPORTANT TO BE 8 9 10)
          (19 I WISH I WERE 8 9 10)
        6 (PERHAPS I JUST HAVE A POOR ATTITUDE ABOUT MYSELF)
          (19 NIL)
       5 (I 1 BELIEVE NIL NIL NIL 0) 
        6 (4 5 6 7) (1 RESTART)
      4 (I 1 REMEMBER 0)
       5 (I 1 REMEMBER NP_ 1) 
        6 (WHAT DO I REMEMBER ABOUT 4 5 ?) (7 I REMEMBER NIL)
        6 (DO I OFTEN THINK OF 4 5 ?) (7 NIL ANS I DO THINK ABOUT 4 5)
        6 (WHAT MAKES ME THINK OF 4 5 JUST NOW ?)
          (7 NIL MAKES ME THINK OF 4 5)
        6 (HOW DO I FEEL WHEN I THINK OF 4 5 ?)
          (7 I FEEL NIL WHEN I THINK OF 4 5)
      4 (I 1 PERCEIVE 0)
       5 (WHY DO I FEEL THAT 4 ?) (7 NIL) 
     3 (I AM 2 BADPRED 3)
      4 (I AM 2 BADSTATE 3)
       5 (WHAT HAS CAUSED THIS UNPLEASANT STATE ?)
         (19 NIL MADE ME 3 4 5)
      4 (I AM 2 BADQUALITY 3)
       5 (WHAT MAKES ME THINK SO POORLY OF MYSELF ?)
         (19 NIL SAYS 1 2 3 4 5)
       5 (PERHAPS I LIKE TO BERATE MYSELF)
         (19 NIL ANS I DO LIKE TO SAY BAD THINGS ABOUT MYSELF)
       5 (WHAT HAVE I TRIED TO DO ABOUT IT ?)
         (19 I HAVE DONE NIL ABOUT IT)
      4 (I AM 2 BADTHING 3)
       5 (DO I REALLY BELIEVE 1 2 3 4 5 ?) (19 NIL ANS 1 2 3 4 5)
       5 (WHAT IS IT ABOUT ME THAT MAKES ME SAY THAT ?)
         (19 NIL MEANS I AM 3 4 5)
     3 (I AM 1 NOT 0 GOODPRED 0)
      4 (WHY THE NEGATIVE ATTITUDE TOWARDS MYSELF ?)
        (9 NIL)
      4 (IS IT IMPORTANT TO YOU TO BE 5 6 7 ?)
        (9 NIL ANS I DO WISH I WERE 5 6 7)
     3 (I AM 2 GOODPRED 0)
      4 (WELL\, THAT\'S A GOOD ATTITUDE TO TAKE)
        (19 NIL)
      4 (GOOD FOR ME\. WHAT ARE THE IMPLICATIONS OF THAT?)
        (19 NIL)
      4 (GOOD\. GO ON)
        (9 NIL)
     3 (I 2 FEEL 0)
      4 (I FEEL 1 BADPRED 0)
       5 (DO I THINK I HAVE GOOD REASONS FOR FEELING 4 ?)
         (19 NIL ANS I HAVE REASONS FOR FEELING 4)
       5 (HOW EXACTLY DO I ACCOUNT FOR THESE BAD FEELINGS?)
         (19 NIL)
      4 (I DO NOT FEEL 0 GOODPRED 0)
       5 (GIVEN MY SITUATION\, IS THAT AN APPROPRIATE WAY TO FEEL?)
         (19 NIL ANS I SHOULD FEEL BAD)
       5 (EXPLAIN HOW ALL THIS CAME ABOUT) (19 NIL)
      4 (WHY DO I FEEL THIS WAY?) (19 NIL)
      4 (PERHAPS THAT IS UNDERSTANDABLE) 
        (19 NIL ANS 1 2 3 4)
      4 (DO I THINK MY FEELINGS ARE APPROPRIATE?)
        (19 NIL ANS I HAVE REASON TO FEEL THIS WAY)
     3 (I 1 WANT 0)
      4 (I 1 WANT TO 0)
       5 (IF I WERE TO 5 \, WHAT WOULD BE THE RESULT?) (19 NIL)
       5 (WHY DO I 3 TO?) (19 NIL)
      4 (I 1 WANT NIL 1 TO 0)
       5 (IS IT A GOOD IDEA 4 5 6 7 ?)
         (19 NIL ANS I DO WANT 4 5 6 7)
      4 (I WANT 2)
       5 (AND IF I HAD 3  \, WHAT WOULD THAT DO FOR ME ?)
         (19 IT WOULD DO NIL FOR ME)
       5 (DO I FEEL IT IS RIGHT FOR ME TO WANT 3 ?)
         (19 NIL ANS I SHOULD HAVE 3)

    2 (YOU 0)
     3 (YOU ARE 0)
      4 (YOU ARE 0 BADPRED 0)
       5 (WHY BOTHER INSULTING YOU ?)
         (19 NIL)
       5 (THERE\'S NO POINT IN SAYING THAT - TALK ABOUT MYSELF)
         (19 NIL)
       5 (NO YOU ARE NOT\. BUT LET\'S GET ON WITH MY PROBLEM)
         (19 NIL)
       5 (PERHAPS - DOES THAT PLEASE ME ?)
         (19 NIL ANS I AM GLAD YOU ARE 3 4)
       5 (ENOUGH OF THAT\. GO ON ABOUT MYSELF)
         (19 NIL)
      4 (YOU ARE 1 NOT 2 GOODPRED 0)
       5 (NO ONE\'S PERFECT)
         (19 NIL)
       5 (DID I EXPECT YOU TO BE 5 6 7 ?)
         (19 NIL ANS YOU OUGHT TO BE 5 6 7 ?)
      4 (YOU 0 STUPIDTHING 0) ; Handle as 1-word insult
       5 (3) (1 RESTART) 
      4 (YOU ARE 0 GOODPRED 0)
       5 (THANK ME - AND WHAT ABOUT ME ?) (19 NIL)
     3 (AND I ?) (19 NIL)
     3 (IT\'S TIME TO TALK ABOUT MY PROBLEMS AGAIN) (19 NIL)
     3 (THE SUBJECT OF CONVERSATION IS *YOU*) (25 NIL)

    2 (NP_ 4 BADPRED 0)
     3 (I 4 BADPRED 0)
      4 (I 4 VIOLENCE 0)
       5 (THAT IS GRIM NEWS\. DO TELL YOU WHY)
         (19 NIL)
       5 (YOU MAY HAVE TO NOTIFY THE AUTHORITIES\.
	   HOW DO I EXPLAIN THESE ACTIONS ?)
         (19 NIL)
       5 (WHY WOULD I DO SUCH A THING ?)
         (19 NIL)
       5 (OH DEAR\. TELL YOU MORE)
         (19 NIL)
       5 (AM I SORRY ABOUT IT ?)
         (19 NIL ANS I DO REGRET IT)
      4 (I 3 BADATTITUDE 0)
       5 (BUT WHY DO I FEEL THIS WAY?)
         (19 NIL)
       5 (THAT\'S UNFORTUNATE)
         (9 NIL ANS 1 2 3 4)
       5 (PERHAPS I SHOULD CHANGE MY ATTITUDE)
         (19 NIL)
       5 (WHY DO I FEEL THIS WAY ?)
         (9 NIL)
       5 (IT\'S NOT GOOD TO FEEL THIS WAY - WHY DO I?) (19 NIL)
     3 (DET NIL 0 BADPRED 0)
      4 (DET NIL 0 VIOLENCE 0)
       5 (THIS IS SERIOUS -- THE POLICE SHOULD BE NOTIFIED)
         (19 NIL ANS A CRIME HAS BEEN COMMITTED)
       5 (THIS IS NOT A PSIACHIATRIC PROBLEM - IT\'S FOR THE POLICE)
         (19 NIL ANS A CRIME HAS BEEN COMMITTED)
      4 (DET NIL 0 BADPROP 0)
       5 (WHY DO I FEEL THAT WAY ABOUT 1 2 ?) (19 NIL)
       5 (IS THAT REALLY A FAIR STATEMENT ABOUT 1 2 ?)
         (19 NIL ANS 1 2 3 4 5)
     3 (PRON 0 BADPRED 0)
      4 (PRON 0 VIOLENCE 0)
       5 (PLEASE REPORT THIS TO THE AUTHORITIES)
         (9 NIL ANS A CRIME HAS BEEN COMMITTED)
       5 (THIS IS SERIOUS -- POLICE INTERVENTION IS REQUIRED)
         (9 NIL ANS A CRIME HAS BEEN COMMITTED)
      4 (PRON 0 BADPROP 0)
       5 (PERHAPS 1 CANNOT HELP THAT) (19 NIL)
       5 (WHOSE FAULT IS THAT?) (19 IT IS NIL FAULT)

    2 (0 MONEYTHEME 0)
     3 (I 0 MONEY 0)
      4 (I 0 NOMONEY 0)
       5 (WHAT HAS CAUSED MY MONEY PROBLEMS ?)
         (19 NIL CAUSED MY MONEY PROBLEMS)
      4 (I 0 NO MONEY 0)
       5 (HOW DID MY MONEY PROBLEMS COME ABOUT ?)
         (19 NIL)
      4 (I 0 NOT 0 MONEY 0)
       5 (HOW DID I GET INTO FINANCIAL DIFFICULTY ?)
         (19 NIL)
      4 (I 0 WANT 0 MONEY 2)
       5 (HOW DID MY MONEY SHORTAGE ARISE ?)
         (19 NIL)
      4 (I 0 MONEY TROUBLE 0)
       5 (HOW DID I GET INTO THIS TROUBLESOME SITUATION ?)
         (19 NIL)
      4 (I 0 NOMORE 2 MONEY 0)
       5 (HOW DID THIS HAPPEN ?)
         (19 NIL)
      4 (0 ENDS MEET 0)
       5 (HOW DID MY MONEY TROUBLES COME ABOUT ?)
         (19 NIL)
      4 (HAVE I TRIED GETTING ANY FINANCIAL HELP ?)
        (19 NIL ANS SOMEONE DID HELP ME)
      4 (CAN ANY FRIENDS HELP OUT ?)
        (19 NIL ANS FRIENDS DO HELP ME)
     3 (IS HAVING LOTS OF MONEY IMPORTANT TO MY HAPPINESS ?)
       (19 NIL ANS I DO WANT LOTS OF MONEY)

    2 (0 MARRIAGETHEME 0)
     3 (0 SPOUSE 0)
      4 (MY SPOUSE 0 AUX 2 LOVER 0)
       5 (WERE THINGS HAPPY IN MY MARRIAGE BEFORE I BEGAN
	    TO THINK THAT?) (19 NIL ANS OUR MARRIAGE WAS HAPPY)
      4 (MY SPOUSE 2 NOT 1 GOODREL ME 0)
       5 (IS THIS RELATED TO MY TROUBLES WITH 1 2 ?)
         (5 STOR NIL ANS THIS IS RELATED TO MY TROUBLES WITH 1 2)
       5 (HOW DO I THINK THIS UNHAPPY SITUATION DEVELOPED?)
         (19 NIL)
      4 (MY SPOUSE 0 BADREL 2 ME 0)
       5 (HOW DID THIS POOR RELATIONSHIP WITH MY 2 DEVELOP?)
         (19 NIL)
      4 (I 0 SPOUSE 0)
       5 (I 2 NOT 2 GOODREL 2 SPOUSE 0)
        6 (HOW DID THIS POOR RELATIONSHIP TO MY 7 DEVELOP?)
          (19 NIL)
       5 (I 0 BADREL 2 SPOUSE 0)
        6 (WHY DO I FEEL THAT WAY ABOUT MY 6 ?)
          (19 NIL)
       5 (YOU WOULD LIKE TO KNOW MORE ABOUT MY RELATIONSHIP TO 
	   MY 3) (19 NIL)
      4 (WHAT IS MY RELATIONSHIP TO MY 2 LIKE ?)
        (19 NIL)
     3 (MY MARRIAGE 0 BADSTATE 0)
      4 (HOW DID THIS SAD SITUATION COME ABOUT?)
        (19 NIL)
      4 (WHY ARE THINGS SO BAD WITH MY MARRIAGE?)
        (29 NIL)
     3 (MY MARRIAGE 2 NEG 2 GOODPRED 0)  
      4 (WHY ISN\'T MY MARRIAGE DOING WELL?)
        (29 NIL)
     3 (0 DIVORCE 0)
      4 (THAT IS A PAINFUL THING\. HOW DID THIS COME ABOUT?)
        (29 NIL)
     3 (HOW DO I FEEL ABOUT MY MARRIAGE?) (29 NIL)
     3 (WHAT DOES MY MARRIAGE MEAN TO ME ?) (29 NIL)

    2 (3 PETTHEME 0)
     3 (- PET-KEY 0)                ; first input about pets? 
      4 (2 MY PET-TYPE 2 BADOCCUR 0) 
       5 (2 MY PET-TYPE 0 DIED 0)
        6 (OH\, THAT\'S VERY SAD\. TELL YOU MORE ABOUT MY 3 \.)
          (19 PET-KEY 3 NIL) ; e.g., preface next input with "PET-KEY cat" 
        6 (THAT\'S TERRIBLE\. WHAT WAS MY 3 LIKE?)
          (19 PET-KEY 3 NIL)
      4 (2 MY PET-TYPE 2 BADHEALTH 0)
       5 (10 THAT\'S TOO BAD\. DO I THINK MY 3 WILL RECOVER?)
         (19 NIL ANS PET-KEY 3 MY 3 WILL GET WELL AGAIN)
     3 (PET-KEY NIL 3 ANA-PRON 0)   ; non-initial input about a pet or pets
      4 (1 2 3 MY 2 5) (1 RESTART)  ; expand anaphor & restart
     3 (PET-KEY NIL 0)  ; non-initial input about pet, non-anaphoric
      4 (PET-KEY NIL MY PET-TYPE 0)
       5 (YOU UNDERSTAND\. WE GET A LOT OF PLEASURE FROM PETS\. WILL I GET
          ANOTHER 4 ?)
         (19 NIL ANS PET-KEY 2 I WILL GET ANOTHER 4)
       5 (YES\, I MUST REALLY MISS MY 4 A LOT\. MIGHT I GET ANOTHER 4 ?)
         (19 NIL ANS PET-KEY 2 I WILL GET ANOTHER 4)
      4 (PET-KEY NIL 1 I WILL GET ANOTHER 0)  ; answer to previous question
       5 (YOU ARE SURE THAT WOULD MAKE ME FEEL BETTER)
         (5 NIL ANS PET-KEY 2 A NEW 2 WILL MAKE ME FEEL BETTER)
      4 (PET-KEY NIL 0 FEEL BETTER)
       5 (OK\, LET\'S TALK ABOUT SOMETHING ELSE\. TELL YOU ABOUT ANY
          OTHER PROBLEM\.)
         (19 NIL)
      4 (PET-KEY NIL 1 I WILL NOT 0)
       5 (DON\'T I THINK I WOULD LIKE A NEW 2 ?)
         (8 NIL PET-KEY 2 I WOULD LIKE A NEW 2)
      4 (PET-KEY NIL 1 I WOULD LIKE 0)
       5 (YOU THINK SO TOO\. YOU HOPE I FEEL A LITTLE BETTER\.)
         (19 NIL I FEEL BETTER)  ;; don't preface with PET-KEY

       ; TBC *****

    2 (0 LOVELIFE 0)
     3 (0 MY LOVE LIFE 0 BADPRED 0)
      4 (WHY IS IT THAT MY LOVE LIFE IS IN BAD SHAPE?)
        (29 NIL)
     3 (0 MY LOVER 0 NOT GOODPRED 0)
      4 (HOW DO I EXPLAIN THIS ABOUT MY 3 ?) (19 NIL)
     3 (0 MY LOVER 0 BADPRED 0)
      4 (HOW DO I EXPLAIN THIS ABOUT MY 3 ?) (19 NIL)
     3 (I 0 LOVE 0)
      4 (I 4 LOVE 1 YOU 0)
       5 (YOU ARE AFRAID THAT\'S AN UNWORKABLE RELATIONSHIP\.
	   WHAT MAKES ME SAY THIS?) (19 NIL MAKES ME SAY THIS)
      4 (I 4 NOT 2 LOVE 0)
       5 (DO I FEEL I OUGHT TO 5 6 ?)
         (19 NIL ANS I OUGHT TO 5 6)
      4 (I 1 LOVE 0)
       5 (DO I FEEL THAT PERHAPS I SHOULD NOT LOVE 4 ?)
         (19 NIL ANS I DO FEEL BAD ABOUT LIKING 4)
       5 (HOW DOES LOVING 4 AFFECT MY LIFE?)
         (19 LOVING 4 DOES NIL AFFECT MY LIFE)
     3 (WHAT DOES THIS SAY ABOUT MY CONDUCT OF A LOVE RELATIONSHIP?)
       (39 NIL)

    2 (0 SOCIALLIFE 0)
     3 (0 FRIEND 0)
      4 (0 I 0 WANT 0 FRIEND 0)
       5 (WHAT WOULD IT MEAN TO ME TO HAVE MORE FRIENDS?)
         (19 NIL)
      4 (0 FRIEND 0 NOT 0 GOODPRED 0)
       5 (WHY DO I HAVE THIS POOR ATTITUDE TO MY FRIENDS?)
         (19 NIL)
      4 (0 FRIEND 0 BADPRED 0)
       5 (WHAT DOES A GOOD FRIEND MEAN TO ME ?)
         (19 A FRIEND IS NIL)
       5 (WITH FRIENDS LIKE THAT\, WHO NEEDS ENEMIES?)
         (19 NIL NEED BAD FRIENDS)
      4 (0 FRIEND 0 NOMORE 0)
       5 (AM I RESPONSIBLE FOR 1 2 DOING THAT?)
         (19 NIL ANS I DID MAKE 1 2 DO THAT)
      4 (0 I 0 NOMORE 0 FRIEND 0)
       5 (IS THERE ANYTHING ABOUT ME THAT OFFENDS MY FRIENDS?)
         (19 MY FRIENDS DISLIKE NIL)
      4 (0 NEG 0 FRIEND 0)
       5 (HAVE I LOST ANY FRIENDS RECENTLY?)
         (19 NIL ANS I DID LOSE A FRIEND RECENTLY)
      4 (WHEN I THINK OF FRIENDS\, WHAT COMES TO MIND?)
        (19 FRIENDS MAKE ME THINK OF NIL)
      4 (DO I MAKE FRIENDS EASILY?)
        (19 NIL ANS I DO MAKE FRIENDS EASILY)
      4 (DO I PUT ANY EFFORT INTO FRIENDSHIPS?)
        (19 NIL ANS I DO WORK ON MY FRIENDSHIPS)
      4 (DO I THINK WELL OF MYSELF\, NO MATTER WHAT
	  MY FRIENDS THINK?)
        (19 NIL ANS I AM SATISFIED WITH MYSELF)
     3 (0 FUN 0)
      4 (0 NEG 0 FUN 0)
       5 (DOES 4 MEAN A LOT TO ME ?)
         (19 NIL ANS 4 IS IMPORTANT TO ME)
      4 (DO I GO OUT OFTEN ENOUGH ?) 
        (19 NIL ANS I DO HAVE A LOT OF FUN)
      4 (DO I ENJOY SUCH OCCASIONS ?)
        (19 NIL ANS I DO ENJOY 2 OCCASIONS)

    2 (0 FAMILY 0)
     3 (0 FAMILY1 0)
      4 (I 0 BADPRED 0 FAMILY1 0)
       5 (I 0 BADREL 0 FAMILY1 0)
        6 (DO I THINK I SHOULD NOT 2 3 4 5 ?)
          (19 NIL ANS I SHOULD NOT 2 3 4 5)
        6 (DO I THINK THINGS ARE BETTER IN OTHER FAMILIES?)
          (19 NIL)
      4 (I 0 NOT 0 GOODPRED 0 FAMILY1 0)
       5 (WHY DO I FEEL THAT WAY ABOUT MY 7 ?)
         (19 NIL)
       5 (DO I FEEL GUILTY ABOUT MY ATTITUDE?)
         (19 NIL ANS I DO FEEL BAD ABOUT IT)
      4 (0 FAMILY1 0 BADPRED 0)
       5 (IS IT SO UNUSUAL FOR ONE\'S 2 TO BE LIKE THAT?)
         (19 NIL 1 2 3 4 5)
       5 (PERHAPS MY OWN ATTITUDE TOWARD MY 2 LEAVES SOMETHING
	       TO BE DESIRED?)
         (19 NIL ANS I AM NASTY TOWARD MY 2)
      4 (HOW DO I FEEL ABOUT OTHER MEMBERS OF MY FAMILY?)
        (19 NIL)
      4 (IN GENERAL\, AM I HAPPY IN MY FAMILY?)
        (19 NIL ANS I AM HAPPY IN MY FAMILY)
     3 (0 FAMILY2 0)
      4 (IS IT REALLY IMPORTANT HOW I FEEL ABOUT MY 2 ?)
        (19 NIL ANS MY 2 IS IMPORTANT TO ME)
      4 (HOW DO I FEEL ABOUT MY MORE IMMEDIATE FAMILY?)
        (19 NIL)

    2 (0 WORKTHEME 0)
     3 (I 2 NOT 2 GOODATTITUDE 3 WORK-BOSS 0)
      4 (WHAT EXACTLY IS WRONG WITH MY 7 ?)
        (19 NIL IS BAD)
     3 (I 3 BADATTITUDE 3 WORK-BOSS 0)
      4 (TELL YOU2 WHAT THE PROBLEM WITH MY 5 IS) (19 NIL)
     3 (2 MY WORK-BOSS 0 NOT 2 GOODPRED 0)
      4 (HOW DID THE PROBLEMS WITH MY 3 BEGIN?) (19 NIL)
     3 (2 MY WORK-BOSS 0 BADPRED 0)
      4 (IS IT FEASIBLE FOR ME TO CHANGE JOBS?)
        (19 NIL ANS I CAN CHANGE JOBS)
     3 (0 WORK 0 TOO 0)
      4 (HOW DID THIS SITUATION IN MY 2 DEVELOP?) (10 NIL)
     3 (I 0 TOO 0 WORK 0)
      4 (WHY DO I ?) (19 NIL)
     3 (WHAT DOES MY WORK MEAN TO ME ?)
       (19 MY WORK MEANS NIL TO ME ?)
     3 (COULD MY 2 BE IMPROVED ?)
       (19 NIL ANS MY 2 COULD BE IMPROVED)

    2 (0 SCHOOLTHEME 0)
     3 (2 SCHOOLWORK 0 V 0 DIFFICULT 0)
      4 (DO I ORGANIZE MY STUDY TIME PROPERLY?) 
        (19 NIL ANS I DO STUDY SYSTEMATICALLY)
      4 (WHAT IS MOST DIFFICULT FOR ME ?)
        (19 NIL IS VERY DIFFICULT)
     3 (I 0 BADATTITUDE 0 SCHOOLWORK 0)
      4 (WHY THIS BAD ATTITUDE TOWARDS SCHOOL WORK?) (19 NIL)
      4 (HOW DID MY NEGATIVE ATTITUDE DEVELOP?) (19 NIL)
      4 (IS THERE SOMETHING DISTRACTING ME ?) 
        (19 NIL DISTRACTS ME FROM SCHOOL WORK)
     3 (0 MY TEACHER 0 BADPRED 0)
      4 (WHAT DOES MY 3 THINK OF ME ?)
        (19 NIL)
     3 (0 MUCH 0 SCHOOLWORK 0)
      4 (DO MY CLASSMATES FEEL THE SAME WAY ?)
        (19 NIL ANS THERE IS TOO MUCH SCHOOLWORK)
     3 (0 SCHOOLTHEME 0 BADPRED 0)
      4 (ARE THINGS WORSE FOR ME AT SCHOOL THAN FOR OTHERS?)
        (19 NIL ANS 1 2 MAY BE PARTICULARLY BAD FOR ME)
      4 (PERHAPS IT IS PARTLY A MATTER OF MY OWN ATTITUDE)
        (19 NIL ANS I HAVE A POOR ATTITUDE)
     3 (WHAT THINGS ABOUT 2 ESPECIALLY BOTHER ME ?)
       (19 NIL AT SCHOOL BOTHERS ME MOST)
     3 (DO I FEEL I PUT IN MY BEST EFFORT AT SCHOOL?)
       (19 NIL ANS I DO WORK HARD AT SCHOOL) 
    2 (0 HEALTH-THEME 0)
     3 (0 SELF 0 BADHEALTH 0)
      4 (YOU ARE SORRY - BUT THAT IS A PROBLEM TO TAKE
	   TO MY PHYSICIAN) (19 NIL)
     3 (0 I 0 OLD 0)
      4 (IT IS IMPORTANT TO ACCEPT LIFE AS IT IS)
        (19 NIL)
     3 (0 SELF 0 NOT 0 GOODHEALTH 0)
      4 (HOW DID THIS HEALTH CONDITION ARISE?)
        (19 NIL)
      4 (WHY IS IT THAT 2 3 4 5 6 ?)
        (19 NIL)
     3 (IS MY HEALTH SOMETHING I WORRY ABOUT A LOT?)
       (19 NIL ANS I DO WORRY ABOUT MY HEALTH)
     3 (PERHAPS I SHOULD SEE A PHYSICIAN)
       (19 NIL)

    2 (0 DRUGS 0)
     3 (0 LIQUOR 0)
      4 (0 I 0 LIQUOR 0)
       5 (DO I DRINK SOCIALLY\, OR MORE THAN THAT?)
         (19 NIL)
      4 (DO I CONSIDER DRINKING A VICE?)
        (19 NIL ANS DRINKING IS BAD)
     3 (NP_ O LIQUOR 0)
      4 (DOES IT AFFECT ME VERY BADLY THAT 1 2 3 4 ?)
        (19 NIL ANS IT IS BAD THAT 1 2 3 4)
     3 (0 I 0 DRUGS 0)
      4 (IF I HAVE A DRUG PROBLEM\, WHAT DO I PLAN TO DO ABOUT IT?)
        (19 NIL)
      4 (PERHAPS I AM TRYING TO ESCAPE FROM SOMETHING?)
        (19 NIL ANS I AM TRYING TO ESCAPE FROM SOMETHING)
     3 (NP_ 0 DRUGS 0)
      4 (DOES IT DISTURB ME THAT 1 2 3 4 ?)
        (19 NIL ANS IT IS BAD THAT 1 2 3 4)
     3 (IS THERE SERIOUS ABUSE INVOLVED?)
       (19 NIL ANS THERE IS A SERIOUS DRUG PROBLEM)
     3 (DO I FEEL RESPONSIBLE FOR THE DRUG PROBLEM I SEEM TO HAVE?)
       (19 NIL ANS MY DRUG PROBLEM IS NOT MY FAULT)

    2 (0 CRIME 0)
     3 (IF A CRIME HAS BEEN \COMMITTED\, SHOULDN\'T THE POLICE
	  BE INFORMED?)
       (19 NIL ANS THE POLICE SHOULD BE INFORMED)

    2 (SELF 0 TROUBLE 0)
     3 (WHAT IS THE NATURE OF MY PROBLEM?) (19 NIL)
     3 (TELL YOU2 MORE ABOUT THIS PROBLEM) (19 NIL)
     3 (EXPLAIN MY 3 TO YOU) (19 NIL)


    2 (I AM 0)
     3 (WHY AM I 0 ?)
       (9 NIL)
     3 (AM I REALLY ?)
       (9 NIL ANS I AM 3)

    2 (I AUX NOT 0)
     3 (WHY 2 3 I ?) (9 NIL)
     3 (AM I SURE I 2 3 ?)
       (10 NIL ANS 1 2 3 4)
     3 (PERHAPS I 2 \, BUT DON\'T KNOW IT)
       (19 NIL)

   1 (0 TOO NIL 0)
    2 (TOO 3 IN WHAT RESPECT?) (19 NIL)

   1 (0 QUANT 0) ; strong quantifier
    2 (NEVER MIND 0)
     3 (BUT YOU DO MIND 3) (19 NIL)
    2 (REALLY\, 2 ?) 
      (19 NIL ANS 1 2 3)
    2 (AM I NOT EXAGGERATING?)
      (19 NIL)
    2 (0 QUANTADV 0)
     3 (1 3) (1 RESTART)

   1 (2 ADV 0) ; initial adverb
    2 (PERHAPS 0)
     3 (I DON\'T SEEM QUITE SURE) (14 PERHAPS 2)
     3 (2) (1 RESTART)
    2 (2 POSADV 0) 
     3 (OF COURSE 0)
      4 (THAT\'S NOT |"OF COURSE"| TO YOU) 
        (19 NIL) 
      4 (YES 3) (1 RESTART)
     3 (1 3) (1 RESTART)
    2 (2 NEGADV 0)
     3 (WHY ONLY 2 ?) (5 NIL)
     3 (2 NEGADV 0 AUX 0)
      4 (1 3 4 NOT 5) (1 RESTART)

   1 (NP_ 0) ; probable declarative
    2 (NP_ 0 BADPRED 0) ; bad news about others?
     3 (NP_ 0 ADV 0)
      4 (1 2 4) (1 RESTART)
     3 (NP_ 0 BADPROP 0)
      4 (NP_ 1 V 0)
       5 (WHY DO I THINK 1 2 3 4 ?) (19 NIL)
       5 (HAVE I ALWAYS FELT THAT 1 2 3 ?)
         (19 NIL ANS 1 2 3 4)
       5 (AM I REALLY JUSTIFIED IN SAYING 1 2 3 ?)
         (19 NIL ANS 1 2 3 4)
       5 (WHAT OPINION MIGHT 1 2 HAVE ABOUT ME ?) (19 NIL)
       5 (ISN\'T THAT PERHAPS A SOMEWHAT HARSH ASSESSMENT?)
         (19 NIL ANS IT IS UNTRUE THAT 1 2 3 4)
     3 (NP_ 0 BADREL 0)
      4 (NP_ 1 V 0)
       5 (WHY IS THIS RELATIONSHIP SO POOR?) (19 NIL)
       5 (AM I REALLY IN A POSITION TO PASS SUCH A JUDGEMENT?)
         (19 NIL ANS 1 2 3 4)
       5 (HOW CAN THIS BE CHANGED?) (19 NIL)
       5 (WHAT DO I THINK IS THE UNDERLYING REASON FOR THAT?)
         (19 NIL)
       5 (IS THIS IN SOME WAYS BECAUSE OF ME ?) 
         (19 NIL ANS 1 2 3 4 BECAUSE OF ME)
    2 (3 MODAL 0)
     3 (3 CAN 0)
      4 (3 CAN NOT 0)
       5 (WHY CAN\'T 1 ?) (19 NIL)
       5 (SHOULD 1 ?) (19 NIL ANS 1 SHOULD 3)
      4 (IS IT GOOD OR WORRISOME THAT 1 CAN?)
        (19 IT IS NIL THAT 1 2 3) 
      4 (SUPPOSE 1 COULD NOT -- HOW WOULD I FEEL ABOUT THAT?)
        (19 I WOULD FEEL NIL ABOUT THAT)
      4 (WHAT ABOUT THE FACT THAT 1 CAN?) (19 NIL)
     3 (3 SHOULD 0)
      4 (3 SHOULD NOT 0)
       5 (WHY SHOULD NOT 1 4 ?) (19 NIL)
       5 (CAN I REALLY JUDGE THAT?) (19 NIL 1 2 3)
       5 (TELL YOU2 WHY 1 SHOULD NOT) (19 NIL)
      4 (WHY SHOULD 3 ?) (19 NIL)
      4 (WHAT MAKES ME THINK 1 SHOULD?) (19 NIL)
      4 (HOW DO I ARRIVE AT THAT JUDGEMENT?) (19 NIL)
     3 (3 OUGHT 0)
      4 (3 OUGHT NOT 0)
       5 (1 SHOULD NOT 4) (1 RESTART)
      4 (3 OUGHT TO 0)
       5 (1 SHOULD 4) (1 RESTART)
    2 (0 SCARYTHING 0)
     3 (IS THAT A FRIGHTENING THING TO ME ?) 
       (19 NIL ANS I AM AFRAID OF THAT)
     3 (IT MIGHT BE NATURAL FOR ME TO WORRY ABOUT THAT)
       (19 NIL)
    2 (0 WANT 0)
     3 (WANTING SOMETHING IS NOT SUFFICIENT\. WHAT AM I OR
	       ANYONE ELSE DOING ABOUT IT?) 
       (19 I AM DOING NIL)
     3 (WHAT IF THAT WISH WERE FULFILLED?) (19 NIL)

   1 (IT 0)
    2 (IT AUX 0)
     3 (IT AUX NOT 0)
      4 (IF IT 2 NOT THEN WHY NOT?) (19 NIL)
      4 (AM I QUITE SURE IT 2 NOT?) (19 NIL 1 2 3 4)
      4 (WHAT IF I AM MISTAKEN AND IT 2 4 ?) (19 NIL)
      4 (WELL |,| WHY SHOULD IT 2 ?) (19 NIL)
     3 (IF IT 2 \, WHY DO I THINK IT 2 ?) (19 NIL)
     3 (BUT PERHAPS IT 2 NOT\.  WHAT MAKES ME SO SURE?) (19 NIL)
     3 (ASSUMING IT 2 \,  WHAT DOES THAT SUGGEST TO ME ?) (19 NIL)
     3 (DO I WISH IT WERE OTHERWISE?) 
       (19 NIL ANS I DO WISH IT 2 NOT 3)
    2 (IT 0 THAT NP_ 0 V 0)
     3 (4 5 6 7) (1 RESTART)

   1 (THAT AUX 0)
    2 (THAT AUX NOT 0)
     3 (MAYBE NOT\. BUT SUPPOSE IT 2 ?) (19 NIL)
     3 (WHAT MAKES ME SO SURE IT 2 NOT ?) (19 NIL MAKES ME SURE)	
     3 (IF IT 2 NOT \,  WHAT DOES THAT MEAN TO ME ?) (19 NIL)
    2 (IF IT 2 \, WHY SO?) (19 NIL)
    2 (AM I SURE IT 2 ?) (19 NIL 1 2 3)
    2 (I SEEM TO GET SOME SATISFACTION FROM SAYING IT 2)
      (19 NIL ANS I AM GLAD THAT IT 2 3)
    2 (AND IF IT WERE NOT SO?) (19 NIL)

   1 (PRON AUX 0)
    2 (PRON AUX NOT 0)
     3 (WHY 2 NOT 1 ?) (5 NIL)
     3 (IF 1 2 NOT \, WHAT DOES THAT SUGGEST TO ME ?)
       (19 IT SUGGESTS NIL TO ME)
     3 (WHAT IF\, IN FACT\, 1 2 ?) (19 NIL)
    2 (WHY 2 1 ?) (5 NIL)
    2 (IF 1 2 \, WHAT DOES THAT SUGGEST TO ME ?)
      (19 THAT SUGGESTS NIL TO ME)
    2 (WHAT IF 1 2 NOT ?) (19 NIL 3)

   1 (V 0) ; probable imperative
    2 (WHAT AM I TRYING TO TELL YOU2 ?)
      (19 I AM TRYING TO TELL YOU NIL)
    2 (LEAVE IT TO YOU2 TO MAKE SUGGESTIONS) (19 NIL)

   1 (PLEASE EXPLAIN) (19 NIL) ; top-level default replies
   1 (PLEASE ELABORATE) (19 NIL)
   1 (MAYBE WE CAN TALK ABOUT SOMETHING ELSE? TELL YOU2 ABOUT
      ANY OTHER PROBLEM I MAY HAVE\.) 
     (19 NIL ANS I QUIT); quit for 1-2-word answer
   1 (OK\, PLEASE CONTINUE) (19 NIL)
   1 (SHALL WE CLOSE THE SESSION NOW?)
     (19 NIL ANS I AM FINISHED)
   1 (WHAT AM I GETTING AT ?) (19 NIL)
   1 (THAT\'S A BIT PUZZLING) (19 NIL)
   1 NIL (5 RETR)
   1 (VERY INTERESTING\. GO ON) (9 NIL)
   1 (3)
    2 (YOU WILL NEED A LITTLE MORE TO GO ON) (19 NIL)
   1 (IS ANYTHING ELSE BOTHERING ME ?) (19 NIL BOTHERS ME)
   1 (WHAT IS MOST IMPORTANT TO ME IN LIFE?) 
     (99 NIL IS MOST IMPORTANT TO ME)
   1 (WHAT DO I LIKE TO DAYDREAM ABOUT?)
     (99 I LIKE TO THINK ABOUT NIL) 
   1 (TELL YOU2 ABOUT ANY GENERAL FEARS OR WORRIES I MIGHT HAVE)
     (99 I WORRY ABOUT NIL) 
   1 (IF I COULD MAKE A WISH\, WHAT WOULD I WISH FOR?)
     (99 I WANT NIL) 
   1 (HOW DO I FEEL ABOUT THIS ?) (19 I FEEL NIL ABOUT IT)
   1 (SAY SOMETHING MORE SPECIFIC) (19 NIL) 
   1 (IF I JUST LET MY MIND WANDER\, WHAT COMES TO MIND?)
     (99 I OFTEN THINK OF NIL)
   1 (GO ON) (0 NIL)

   ))

   (SETQ *TRACERULES* NIL))





