(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '((garbage plate plates tahoe tahoes)
  	(park parks highland GVP valley woods letchworth)
  	(waterways genessee lake river ontario irondequoit)
  	(art-gallery memorial art gallery)
  	(rochester-restaurant Nick Tahou\'s garbage plate Dinosaur Barbecue Aladdin\'s Chipotle Pane Vino Tapas Lounge Tavern Vine Lento Good Luck Gate House Max Owl Golden Port Dim Sum Galleria Rocco LaLuna He\'s Salena\'s Tournedos Tornadoes Tony D\'s Edibles Espada Brazilian Espada Hot Rosita\'s Rocky\'s Pellegrino\'s Scotland Yard Char Christopher\'s Veneto John\'s Tex-Mex Matthew\'s East End Magnolia\'s Bacco\'s Hogan\'s Hideaway Roncone\'s New Star Panzari\'s Jines he nays El Savor de la Isla El Taino Chen\'s Garden Monte Alban Elmwood Inn Sinbad\'s Stromboli\'s Greens Legends Dogtown dog town Sticky Lips Distillery Tropics Stock Exchange Spiro\'s Villa Bill Gray\'s Trata El Latino Mitch\'s mitches Village Phillips Phillip\'s Philip\'s Chophouse Bazil basil Delmonico\'s Taste of Ethiopia Mex Wang\'s Fiamma New Fong Ristorante Lucano Papa Joe\'s Busy Bee Peppa Pot Havana Cuba Keenan\'s Rizzi\'s Grinnell\'s Latino Antonetta\'s King Foo People\'s Choice Park Avenue Pub Park Ave Remington\'s Rick\'s Prime Rib New China Eros Nikko Thai Lao Charlie Brown\'s Meda Zeppa Osteria Trinities Yangtze Romeo\'s Henry B\'s Cafe Cibon Carmine\'s Red Front Peppermill Tip Top Nathaniel\'s Great Win Sal\'s Birdland East Ridge Pomodoro Olympia Valicia\'s Central Park Family Diner Hose China Star McGinnity\'s Mr\. Dominic\'s Shui Pelican\'s Nest CJ\'s Southern Soul Campi\'s campies Jim\'s McDonald\'s King Hut Wendy\'s Chipotle pit Danforth Douglass Douglas Mel Panda Express Tim Horton\'s DiBella\'s Cam\'s Bunga Burger Saha India House Grappa Pura Vida Blimpie Starbucks Subway Brooks Landing Boulder Pittsford Holley\'s Holly\'s hollies Steve T\'s Jay\'s)
    (restaurant-type Chinese Mexican Japanese Italian Peruvian Thai Ethiopian Indian Mediterranean burger pizza grill diner cafe)
    (see-music music concert live show)
    (waterfall falls fall)))

 (READRULES '*specific-answer-from-tour-of-rochester-input*
  '(1 (0 museum of play 0)
  	  2 ((I would take you to the museum of play \.) (Rochester-tour)) (0 :gist)
    1 (0 eastman house 0)
      2 ((I would take you to George Eastman house \.) (Rochester-tour)) (0 :gist)
    1 (0 eastman school 0)
      2 ((I would take you to the Eastman school \.) (Rochester-tour)) (0 :gist)
    1 (0 art-gallery 0)
      2 ((I would take you to an art gallery \.) (Rochester-tour)) (0 :gist)
    1 (0 park 0)
      2 ((I would take you to a park \.) (Rochester-tour)) (0 :gist)
    1 (0 rochester-restaurant 0)
      2 ((I would take you to 2 \.) (Rochester-tour)) (0 :gist)
    1 (0 waterfall 0)
      2 ((I would take you to a waterfall \.) (Rochester-tour)) (0 :gist)  
    1 (0 see-music 0)
      (I would take you to see music \.)
  ))
 
 (READRULES '*thematic-answer-from-tour-of-rochester-input*
    '(1 (0 waterways 0)
       2 ((I would take you to the water \.) (Rochester-tour)) (0 :gist)
      1 (0 see-music 0)
       2 ((I would take you to see music \.) (Rochester-tour)) (0 :gist)
      1 (0 restaurant-type 0)
       2 ((I would take you to a restaurant \.) (Rochester-tour)) (0 :gist)
  ))

 (READRULES '*unbidden-answer-from-tour-of-rochester-input*
    '(1 (0 dinosaur 0)
	   2 ((I have been to Dinosaur BBQ\.) (dinosaur)) (0 :gist)
	  1 (0 garbage 0)
	   2 ((I like garbage plates\.) (garbage-plate)) (0 :gist)
	  1 (0 rochester-restaurant 0)
	   2 ((My favorite place to eat is 2 \.) (Rochester-eateries))
  ))

 (READRULES '*question-from-tour-of-rochester-input* 
  '(1 (0 you 0 want to see 0)
  	 2 (What would you want to see ?) (0 :gist)
  	1 (0 what 0 you 0 like 0)
  	 2 (What would you want to see ?) (0 :gist)))
 
 (READRULES '*reaction-to-tour-of-rochester-input*  
  '(1 (0 rochester-restaurant 0)
     2 (That sounds delicious !) (100 :out)
    1 (0 eastman school 0)
     2 (Oh\, cool\. you have heard a lot about Eastman school !) (100 :out)
    1 (0 Eastman house 0)
     2 (Oh\, cool\. you love to see the museum and learn more about the Kodak founder !) (100 :out)
    1 (0 art gallery 0)
     2 (Oh\, I have an artistic taste !) (100 :out)
    1 (0 park 0)
     2 (Oh\, you love nature !) (100 :out)
    1 (0 waterfall 0)
     2 (Oh\, you would love to see there !) (100 :out)
    1 (0 see music 0)
     2 (That sounds like a nice way to spend the day \.) (100 :out)
    1 (0)
     2 (That sounds like a nice way to spend the day \.) (100 :out)
    )); end of *reaction-to-tour-of-rochester-input*

); end of eval-when