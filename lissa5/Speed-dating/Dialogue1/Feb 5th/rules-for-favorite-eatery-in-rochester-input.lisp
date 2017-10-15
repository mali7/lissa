(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((rochester-restaurant Nick Tahou\'s garbage plate Dinosaur Barbecue Aladdin\'s Chipotle Pane Vino Tapas Lounge Tavern Vine Lento Good Luck Gate House Max Owl Golden Port Dim Sum Galleria Rocco LaLuna He\'s Salena\'s Tournedos Tornadoes Tony D\'s Edibles Espada Brazilian Espada Hot Rosita\'s Rocky\'s Pellegrino\'s Scotland Yard Char Christopher\'s Veneto John\'s Tex-Mex Matthew\'s East End Magnolia\'s Bacco\'s Hogan\'s Hideaway Roncone\'s New Star Panzari\'s Jines he nays El Savor de la Isla El Taino Chen\'s Garden Monte Alban Elmwood Inn Sinbad\'s Stromboli\'s Greens Legends Dogtown dog town Sticky Lips Distillery Tropics Stock Exchange Spiro\'s Villa Bill Gray\'s Trata El Latino Mitch\'s mitches Village Phillips Phillip\'s Philip\'s Chophouse Bazil basil Delmonico\'s Taste of Ethiopia Mex Wang\'s Fiamma New Fong Ristorante Lucano Papa Joe\'s Busy Bee Peppa Pot Havana Cuba Keenan\'s Rizzi\'s Grinnell\'s Latino Antonetta\'s King Foo People\'s Choice Park Avenue Pub Park Ave Remington\'s Rick\'s Prime Rib New China Eros Nikko Thai Lao Charlie Brown\'s Meda Zeppa Osteria Trinities Yangtze Romeo\'s Henry B\'s Cafe Cibon Carmine\'s Red Front Peppermill Tip Top Nathaniel\'s Great Win Sal\'s Birdland East Ridge Pomodoro Olympia Valicia\'s Central Park Family Diner Hose China Star McGinnity\'s Mr\. Dominic\'s Shui Pelican\'s Nest CJ\'s Southern Soul Campi\'s campies Jim\'s McDonald\'s King Hut Wendy\'s Chipotle pit Danforth Douglass Douglas Mel Panda Express Tim Horton\'s DiBella\'s Cam\'s Bunga Burger Saha India House Grappa Pura Vida Blimpie Starbucks Subway Brooks Landing Boulder Pittsford Holley\'s Holly\'s hollies Steve T\'s Jay\'s)
    (restaurant-type restaurant-type-one restaurant-type-two)
    (restaurant-type-one Chinese Mexican Japanese Italian Peruvian Thai Ethiopian Indian Mediterranean) 
    (restaurant-type-two burger pizza grill diner cafe)))
;; N.B.: FOR THE DECLARATIVE GIST CLAUSES OBTAINED FROM THE USER'S 
;;       RESPONSE TO A LISSA QUESTION, EACH OUTPUT FROM THE CORRESPONDING 
;;       CHOICE PACKETS (DIRECTLY BELOW) MUST BE OF FORM 
;;          (WORD-DIGIT-LIST KEY-LIST), E.G.,
;;          ((My favorite class was 2 3 \.) (favorite-class))
;;       BY CONTRAST, QUESTIONS OBTAINED FROM THE USER RESPONSES,
;;       AND LISSA REACTIONS TO USER RESPONSES, CURRENTLY CONSIST
;;       JUST OF A WORD-DIGIT LIST, WITHOUT A KEY LIST.

; phrases for gist extraction:

 (READRULES '*specific-answer-from-favorite-eatery-in-rochester-input*
   '(1 (0 rochester-restaurant rochester-restaurant 0)
       2 ((My favorite restaurant is 2 3\.) (Rochester-eateries)) (0 :gist)
     1 (0 rochester-restaurant 0)
       2 ((My favorite restaurant is 2\.) (Rochester-eateries)) (0 :gist)
     1 (0 restaurant-type 0)
        2 ((My favorite kind of restaurant is 2\.) (Rochester-eateries)) (0 :gist)))

;(READRULES '*specific-answer-from-favorite-eatery-in-rochester-input*
 ;  '(1 (0 rochester-restaurant rochester-restaurant 0)
  ;     2 ((My favorite restaurant is 2 3\.) (restaurant)) (0 :gist)
   ;  1 (0 rochester-restaurant 0)
    ;   2 ((My favorite restaurant is 2\.) (restaurant)) (0 :gist)))
       
       
 (READRULES '*thematic-answer-from-favorite-eatery-in-rochester-input*
    '())

 (READRULES '*unbidden-answer-from-favorite-eatery-in-rochester-input*
    '(1 (0 dinosaur 0)
        2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
      1 (0 garbage plate 0)
        2 ((I have had a garbage plate\.) (garbage-plate)) (0 :gist)
      1 (0 Nick Tahou\'s 0)
        2 ((I have had a garbage plate\.) (garbage-plate)) (0 :gist)
      1 (0 Steve T\'s 0)
        2 ((I have had a garbage plate\.) (garbage-plate)) (0 :gist)))
 (READRULES '*question-from-favorite-eatery-in-rochester-input*
    '(1 (0 wh_ 1 you 0)
        2 (What is your favorite restaurant ?) (0 :gist)
      1 (0 you heard 0)
        2 (Have you heard of that restaurant ?) (0 :gist)
      1 (0 you been 0)
        2 (Have you been to that restaurant ?) (0 :gist)))

(READRULES '*reaction-to-favorite-eatery-in-rochester-input*
   '(1 (0 rochester-restaurant 0)
       2 (You have not been there\, but it sounds nice\.) (100 :out)
     1 (0 restaurant-type 0)
       2 (0 restaurant-type-one 0)
        3 (You like 2 food too\.) (100 :out)
       2 (0 restaurant-type-two 0) 
        3 (You like that kind of food too\.) (100 :out))); end of *reaction-to-restaurant-input*
); end of eval-when
