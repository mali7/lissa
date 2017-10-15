(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (food-categories vegan vegetarian seafood vegetables fruit dessert grain nuts dairy meat)
  (food-ethnicity Asian Chinese Mexican Japanese Italian Korean Peruvian Thai Ethiopian Indian Mediterranean Greek Cambodian German Polish Spanish)
  (food-seafood fish cod eel herring salmon sardine sardines swordfish tilapia trout tuna
    caviar crab lobster shrimp oyster clam clams squid octopus calamari sushi)
  (food-vegetables salad celery broccoli garlic cauliflower cucumber spinach leek pumpkin
    beets kale zucchini cabbage carrot carrots lettuce asparagus potato tomato eggplant
    pepper quinoa avocado soy pickle pickles corn pea peas mushroom mushrooms onion onions)
  (food-fruit apple banana orange strawberry grape pear cherry peach lemon mango blueberry
    berry watermelon melon grapefruit pomegranate blackberry apricot cranberry coconut
    tangerine cantaloupe honeydew olive olives plantains)
  (food-dessert cookie cookies brownies candy pie cheesecake chocolate custard pastry
    pastries ice cream doughnut donut doughnuts donuts shortcake sundae)
  (food-grain pasta spaghetti rice noodles oats oatmeal bread toast cereal bran pancake
    pancakes waffle waffles)
  (food-nuts almond almonds walnut walnuts peanut peanuts hazelnut hazelnuts pistachio pistachios
    cashew cashews pecan pecans chestnut chestnuts)
  (food-dairy butter cheese cheddar mozzarella parmesan milk yogurt pudding egg eggs omelette)
  (food-meat beef pork chicken lamb duck meatball meatballs sausage steak ribs pepperoni ham
    salami bacon turkey)
  (food-misc french fries hot dog burger hamburger burgers hamburgers taco tacos stuffing pizza
    chili sandwich sandwiches sub subs bagel bagels curry soup stew bean beans)
  ))
   
;;  (what is your favorite food ?)
;;	(favorite-food)
;; 	from-favorite-food-input
;;  (0 food I like 0)
;;  	gist-question: (1 what 2 favorite 2 food 1) 


 (READRULES '*specific-answer-from-favorite-food-input*
  '(
  1 (0 food-seafood 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-vegetables 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-fruit food-dessert 0) ;; e.g. "apple pie", "strawberry shortcake"
     2 ((The food I like is 2 3 \.)  (favorite-food)) (0 :gist)
  1 (0 food-fruit 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-dessert food-dessert) ;; e.g. "ice cream"
     2 ((The food I like is 2 3 \.)  (favorite-food)) (0 :gist)
  1 (0 food-dessert 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-grain 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-nuts 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-dairy 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-meat food-misc 0) ;; e.g. "turkey sandwich", "pork tacos"
     2 ((The food I like is 2 3 \.)  (favorite-food)) (0 :gist)
  1 (0 food-meat 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-misc 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-ethnicity 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-categories 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)

  ;; NEEDS 'DEFAULT' CASE FOR WHEN PERSON DOESN'T HAVE A FAVORITE FOOD

  ))
       
       
 (READRULES '*thematic-answer-from-favorite-food-input*
    '())

 (READRULES '*unbidden-answer-from-favorite-food-input*
    '())
		
 (READRULES '*question-from-favorite-food-input*
    '(
    1 (0 what 2 you 0)
       2 (What is your favorite food ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What is your favorite food ?) (0 :gist)
	  1 (0 your favorite 0)
       2 (What is your favorite food ?) (0 :gist)
    1 (0 do you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 can you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    ))

(READRULES '*reaction-to-favorite-icecream-flavor-input*
  '( 
  1 (0 food-seafood 0)
     2 (You really like 2 \. Seafood is one of your favorite types of food \.) (100 :out)
  1 (0 food-vegetables 0)
     2 (You like 2 \. It\'s nice when food is healthy and tastes good \.) (100 :out)
  1 (0 food-fruit food-dessert 0) ;; e.g. "apple pie", "strawberry shortcake"
     2 (You think 2 3 is pretty tasty \. You definitely have a bit of a sweet tooth \.) (100 :out)
  1 (0 food-fruit 0)
     2 (You like 2 \. It\'s nice when food is healthy and tastes good \.) (100 :out)
  1 (0 food-dessert food-dessert) ;; e.g. "ice cream"
     2 (You think 2 3 is pretty tasty \. You definitely have a bit of a sweet tooth \.) (100 :out)
  1 (0 food-dessert 0)
     2 (You really like 2 \. You definitely have a bit of a sweet tooth \.) (100 :out)
  1 (0 food-grain 0)
     2 (You like 2 \. It\'s very filling \.) (100 :out)
  1 (0 food-nuts 0)
     2 (You like 2 \. Crunchy foods are the best \.) (100 :out)
  1 (0 food-dairy 0)
     2 (You like 2 \. It'\s very tasty \.) (100 :out)
  1 (0 food-meat food-misc 0) ;; e.g. "turkey sandwich", "pork tacos"
     2 (You like 2 3 \. It\'s very filling \.) (100 :out)
  1 (0 food-meat 0)
     2 (You like 2 3 \. It\'s very filling \.) (100 :out)
  1 (0 food-misc 0)
     2 (You like 2 \. It'\s very tasty \.) (100 :out)
  1 (0 food-ethnicity 0)
     2 (You haven\'t tried 2 food yet \. You will have to taste it some time \.) (100 :out)
  1 (0 food-categories 0)
     2 (You also like to eat 2 \.) (100 :out)
  1 (0)
     2 (There's lots of amazing food out there to taste \.) (100 :out)
	))
); end of eval-when
