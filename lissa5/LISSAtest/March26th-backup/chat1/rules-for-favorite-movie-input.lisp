(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '())

 ; I have yet to think of a good way of doing this--here's one
 (READRULES '*specific-answer-from-favorite-movie-input*
  '(1 (0 favorite 3 is probably 2 0)
     2 ((My favorite movie is 6 \.) (favorite-movie)) (0 :gist)
    1 (0 favorite 3 is 2 0)
	 2 ((My favorite movie is 5 \.) (favorite-movie)) (0 :gist)
	1 (0 favorite 4 be 2 0)
	 2 ((My favorite movie is 5 \.) (favorite-movie)) (0 :gist)
	1 (0 like 2 0)
	 2 ((My favorite movie is 3 \.) (favorite-movie)) (0 :gist)
	1 (2 no I 1 NEG 2 0)
	 2 ((I can not say a movie as my favorite movie \.) (favorite-movie)) (0 :gist)
	1 (0 NEG 1 have 2 0)
	 2 ((I can not say a movie as my favorite movie \.) (favorite-movie)) (0 :gist)
	1 (0 I don\'t 0)
	 2 ((I can not say a movie as my favorite movie \.) (favorite-movie)) (0 :gist)
	1 (0 NEG 2 really 2 0)
	 2 ((I can not say a movie as my favorite movie \.) (favorite-movie)) (0 :gist)
	1 (0 really 2 NEG 2 0)
	 2 ((I can not say a movie as my favorite movie \.) (favorite-movie)) (0 :gist)
	1 (0 3 0) 
	 2 ((Nothing found for my favorite movie \.) (favorite-movie)) (0 :gist)))
 
 ; No thematic answers anticipated
 (READRULES '*thematic-answer-from-favorite-movie-input*
  '())

 (READRULES '*unbidden-answer-from-favorite-movie-input*
  '(1 (0 new star wars 0)
     2 ((I have seen the new Star Wars film \.) (seen-star-wars)) (0 :gist)))

  ; Reciprocal question
 (READRULES '*question-from-favorite-movie-input* 
  '(1 (0 what 1 you 0)
     2 (What is your favorite movie ?) (0 :gist)
	1 (0 how 1 you 0)
	 2 (What is your favorite movie ?) (0 :gist)
    1 (0 what 1 your favorite movie 0)
	 2 (What is your favorite movie ?) (0 :gist)
	1 (0 what movie 1 you like 0)
	 2 (What is your favorite movie ?) (0 :gist)
    1 (0 do you have 2 favorite 0)
	 2 (What is your favorite movie ?) (0 :gist)
     ))
 
 ; The reaction really should be a subdialogue, but for now we can do this
 (READRULES '*reaction-to-favorite-movie-input*  
  '(1 (0 My favorite movie is 0)
     2 (You haven\'t seen it\, but you heard it\'s a good one \.) (100 :out)
	1 (0 can not say a movie as my favorite 0)
     2 (Yeah\, You also find it hard to choose one movie to be your favorite\, because you have seen so many good ones \.) (100 :out)
	1 (0 Nothing found 0)
     2 (Cool \.) (100 :out)))

); end of eval-when