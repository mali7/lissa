(eval-when (load eval)

(mapc 'attachfeat '((spare-time-activity sports read reading watch watching play playing hike hiking explore exploring walk walking walks hobby hobbies painting)))

(readrules '*reaction-to-input* '(1 (0 wh_ nil you{r} 0) 2 *reaction-to-question* (0 :subtree) 1 (0 aux you{r} 0) 2 *reaction-to-question* (0 :subtree) 1 (0 right-really 4 ?) 2 *reaction-to-question* (0 :subtree) 1 (0) 2 *reaction-to-assertion* (0 :subtree)))

(readrules '*reaction-to-assertion*
  '(1 (My name 0)
      2 *reaction-to-user-name-input* (0 :subtree)
	1 (My favorite subject 0)
	  2 *reaction-to-favorite-subject-input* (0 :subtree)
	1 (0 drive me 0)
	  2 *reaction-to-drive-you-input* (0 :subtree)
	1 (I like spare-time-activity \.)
	  2 *reaction-to-free-time-input* (0 :subtree)
	1 (It was 1 to get here \.)
	  2 *reaction-to-getting-here-input* (0 :subtree)
	1 (0 not like 0 Rochester 0)
	  2 *reaction-to-not-like-about-rochester-input* (0 :subtree)
	1 (0 like school 0)
	  2 *reaction-to-like-school-input* (0 :subtree)
	1 (I\'ve been in Rochester 0)
	  2 *reaction-to-time-in-rochester-input* (0 :subtree)
    ))

(readrules '*reaction-to-question*
 '(1 (What is your name ?)
    2 (My name is Lissa\.) (100 :out)
))

(readrules '*reaction-to-unexpected* '()))
