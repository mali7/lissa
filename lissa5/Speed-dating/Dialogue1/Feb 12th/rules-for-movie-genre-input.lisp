(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
  '((movie-genre romance comedy horror thriller indie
      foreign documentary independent romantic sci-fi
	  science-fiction action western musical Bollywood
	  animated adventure documentaries musicals French
	  silent anime suspense biopic biopics kids Disney)))

 (READRULES '*specific-answer-from-movie-genre-input*
  '(1 (0 favorite 2 movie-genre 0)
     2 ((My favorite movie genre is 4 \.) (movie-genre)) (0 :gist)
	1 (0 like movie-genre 0)
	 2 ((My favorite movie genre is 3 \.) (movie-genre)) (0 :gist)
	1 (0 NEG 3 favorite 0)
	 2 ((I have no favorite movie genre \.) (movie-genre)) (0 :gist)
	1 (0 NEG know 0)
	 2 ((I have no favorite movie genre \.) (movie-genre)) (0 :gist)
	1 (0 NEG 1 like 1 movies 0)
	 2 ((I have no favorite movie genre \.) (movie-genre)) (0 :gist)
	1 (0 3 0)
	 2 ((Nothing found for favorite movie genre \.) (movie-genre)) (0 :gist)
	 ))
 
 ; No thematic answers anticipated
 (READRULES '*thematic-answer-from-movie-genre-input*
  '())

 ; The user could theoretically give more kinds of unbidden
 ; answers, but the "favorite movie" answer is most likely.
 ; Though this rule is a really unreliable way of extracting that info
 (READRULES '*unbidden-answer-from-movie-genre-input*
  '(1 (0 favorite movie is 2 0)
     2 ((My favorite movie is 5 \.) (favorite-movie)) (0 :gist)))

  ; Reciprocal question
 (READRULES '*question-from-movie-genre-input* 
  '(1 (0 what 1 you 0)
     2 (What is your favorite movie genre ?) (0 :gist)
	1 (0 how 1 you 0)
	 2 (What is your favorite movie genre ?) (0 :gist)
	1 (0 do you like movie-genre 0)
	 2 (Do you like 5 movies ?) (0 :gist)))
 
 (READRULES '*reaction-to-movie-genre-input*  
  '(1 (0 My favorite movie genre is romance \.)
     2 (You do enjoy love stories \.) (100 :out)
    1 (0 My favorite movie genre is romantic \.)
	 2 (You do enjoy love stories \.) (100 :out)
    1 (0 My favorite movie genre is comedy \.)
	 2 (You like movies that make me laugh \.) (100 :out)
	1 (0 My favorite movie genre is horror \.)
	 2 (You especially like those low-budget horror films with lots of fake blood \.) (100 :out)
	1 (0 My favorite movie genre is suspense \.)
	 2 (You especially like those low-budget horror films with lots of fake blood \.) (100 :out)
	1 (0 My favorite movie genre is sci-fi \.)
	 2 (You like sci-fi movies where the computers take over \.) (100 :out)
	1 (0 My favorite movie genre is science-fiction \.)
	 2 (You like sci-fi movies where the computers take over \.) (100 :out)
	1 (0 My favorite movie genre is 1 \.)
	 2 (You haven\'t seen many of those movies \.) (100 :out)
	1 (0 Nothing found 0)
	 2 (Sounds interesting!) (100 :out)
	 ))

); end of eval-when