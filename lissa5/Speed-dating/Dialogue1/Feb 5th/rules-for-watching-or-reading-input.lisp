(eval-when (load eval)
 
  (MAPC 'ATTACHFEAT
   '((like prefer) (books reading) (movies movie cinema film films)
   (streaming netflix hulu) (contrary actually neither none rather)))

  (READRULES '*specific-answer-from-watching-or-reading-input*
   '(1 (0 like books 0)
      2 ((I like reading \.) (watching-versus-reading)) (0 :gist)
	 1 (0 like reading 0)
	  2 ((I like reading \.) (watching-versus-reading)) (0 :gist)
	 1 (0 like TV 0)
	  2 ((I like watching TV \.) (watching-versus-reading)) (0 :gist)
	 1 (0 like movies 0)
	  2 ((I like watching movies \.) (watching-versus-reading)) (0 :gist)
	 1 (0 like watching 0)
	  2 (0 TV 0)
	   3 ((I like watching TV \.) (watching-versus-reading)) (0 :gist)
	  2 (0 movies 0)
	   3 ((I like watching movies \.) (watching-versus-reading)) (0 :gist)
	  2 (0 streaming 0)
	   3 ((I like watching 2 \.) (watching-versus-reading)) (0 :gist)
	  2 ((I like watching TV or movies \.) (watching-versus-reading)) (0 :gist)
	 1 (0 I\'m 0 NEG 0 reader 0)
	  2 ((I like watching TV or movies \.) (watching-versus-reading)) (0 :gist)
	 1 (0 I 0 NEG 0 read 0)
	  2 ((I like watching TV or movies \.) (watching-versus-reading)) (0 :gist)
	 1 (0 I\'m 0 reader 0)
	  2 ((I like reading \.) (watching-versus-reading)) (0 :gist)
	 1 (0 I read 0)
	  2 ((I like reading \.) (watching-versus-reading)) (0 :gist)
	 1 (0 I watch 0)
	  2 (0 TV 0)
	   3 ((I like watching TV \.) (watching-versus-reading)) (0 :gist)
	  2 (0 movies 0)
	   3 ((I like watching movies \.) (watching-versus-reading)) (0 :gist)
	  2 (0 streaming 0)
	   3 ((I like watching 2 \.) (watching-versus-reading)) (0 :gist)
	  2 ((I like watching TV or movies \.) (watching-versus-reading)) (0 :gist)
	 1 (0 contrary 0 like spare-time-activity 0)
	  2 ((I like 5 \.) (watching-versus-reading)) (0 :gist)
	))

 (READRULES '*thematic-answer-from-watching-or-reading-input*
   '())

 ; to do: figure out gist clauses for the future questions in this conversation
 (READRULES '*unbidden-answer-from-watching-or-reading-input*
   '())

 (READRULES '*question-from-watching-or-reading-input*
   '(1 (0 what 0 you 0)
      2 (Do you like watching TV or movies or reading books ?) (0 :gist)
	 1 (0 how 0 you 0)
	  2 (Do you like watching TV or movies or reading books ?) (0 :gist)
	))

 (READRULES '*reaction-to-watching-or-reading-input*
   '(1 (0 TV 0)
      2 (You like watching TV a lot \.) (100 :out)
	 1 (0 movies 0)
	  2 (You like movies a lot \.) (100 :out)
	 1 (0 books 0)
	  2 (You think books are a great way to spend time \, though you sometimes find it hard to concentrate on them \, since I\'m so animated \.) (100 :out)
	 1 (I like 0 \.)
	  2 (3 sounds like a fun way to spend time \. You like watching movies \.) (100 :out)
	))

); end of eval-when
