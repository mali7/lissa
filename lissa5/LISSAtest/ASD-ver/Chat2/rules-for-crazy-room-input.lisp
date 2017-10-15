(eval-when (load eval)
 (MAPC 'ATTACHFEAT
  '((pictures photograghs)
    (game games)
	(bookcase bookcases library book books)
	(kitchen cooking)
	(pool billiard)
	(music-related music musical instruments)
	(xbox playstation atari)
	(physical basketball tennis)
	(same similar)
	(movies movie tv)
	(garage car cars)
	(sweets candy sweet chocolate)
	(drinking wine liqure drinks drink)
    ))

;; (what would your crazy room be like ?)
;;	(crazy-room)
;;		from-crazy-room-input
;;			(My crazy room is 0)
;;			gist-question:(what 2 crazy room 0)
      
 
 (READRULES '*specific-answer-from-crazy-room-input*
 '(1 (0 board game 0) 
        2 ((My crazy room is a room with board games in it \.)  (crazy-room)) (0 :gist) 
   1 (0 pictures 0) 
        2 ((My crazy room is a room full of pictures \.)  (crazy-room)) (0 :gist) 
   1 (0 movie 0) 
        2 ((My crazy room is a room with a bunch of movies \.)  (crazy-room)) (0 :gist) 
   1 (0 kitchen 0) 
        2 ((My crazy room is a room like a kitchen \.)  (crazy-room)) (0 :gist) 
   1 (0 books 0) 
        2 ((My crazy room is a room with lots of books \.)  (crazy-room)) (0 :gist) 
   1 (0 physical 0) 
        2 ((My crazy room is a room with sport courts in it \.)  (crazy-room)) (0 :gist) 
   1 (0 garage 0) 
        2 ((My crazy room is a room with lots of cars in it \.)  (crazy-room)) (0 :gist) 
   1 (0 sweets 0) 
        2 ((My crazy room is a room with a lot of sweets \.)  (crazy-room)) (0 :gist) 
   1 (0 drinking 0) 
        2 ((My crazy room is a room with a lot of drinks \.)  (crazy-room)) (0 :gist)  
   1 (0 music-related 0) 
        2 ((My crazy room is a room with musical things \.)  (crazy-room)) (0 :gist)  
   1 (0 NEG 3 video game 0) 
        2 ((My crazy room is not a room  with video games in it \.)  (crazy-room)) (0 :gist) 
   1 (0 video game 0) 
        2 ((My crazy room is a room with video games in it \.)  (crazy-room)) (0 :gist) 
   1 (0 same 2 you 0) 
        2 ((My crazy room is a room with video games \.)  (crazy-room)) (0 :gist) 
   1 (0 3 0) 
        2 ((Nothing found for how my crazy room is \.)  (crazy-room)) (0 :gist) 
    ))
 
 (READRULES '*thematic-answer-from-crazy-room-input*
    '())

 (READRULES '*unbidden-answer-from-crazy-room-input*
	())

 (READRULES '*question-from-crazy-room-input*     ;; answer to this question is already there
    '(;;1 (0 what 0 you 0)                 
      ;;  2 (what would your crazy room be like ?) (0 :gist)
      ;;1 (0 how 0 you 0)
      ;;  2 (what would your crazy room be like ?) (0 :gist)
     ))
 
 (READRULES '*reaction-to-crazy-room-input*  
 '(1 (0 board games 0) 
     2 (So I am a board game fan \.) 
	   (100 :out)
   1 (0 pictures 0) 
     2 (Yeah\, a room full of pictures would be very interesting \.) 
	   (100 :out)
   1 (0 books 0) 
     2 (You could spend hours in such a room without being tired \.) 
	   (100 :out) 
   1 (0 movies 0) 
     2 (A movie room would be fantastic \.) 
	   (100 :out) 
   1 (0 kitchen 0) 
     2 (That\'s interesting \.) 
	   (100 :out) 
   1 (0 sport 0) 
     2 (So I enjoy physical activities \.) 
	   (100 :out) 
   1 (0 cars 0) 
     2 (So I are really into cars \.) 
	   (100 :out) 
   1 (0 music-related 0) 
     2 (Wow! I are really into music \.) 
	   (100 :out) 
   1 (0 sweet 0) 
     2 (Sounds delicious but not that healthy \.) 
	   (100 :out) 
   1 (0 drinks 0) 
     2 (Sounds interesting \.) 
	   (100 :out) 
   1 (0 not 0 video games 0) 
     2 (Sounds interesting \.) 
	   (100 :out)
   1 (0 video games 0) 
     2 (So we have something in common \.) 
	   (100 :out)
   1 (0 2 0) 
     2 (Sounds interesting \.) 
	   (100 :out) 
   )); end of *reaction-to-crazy-room-input*

); end of eval-when

