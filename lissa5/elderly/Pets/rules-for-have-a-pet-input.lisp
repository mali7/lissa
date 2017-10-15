(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (pet-types pet-cat pet-dog pet-bird pet-fish pet-other)
  (pet-cat cat cats kitten kittens kitty kitty kitties)
  (pet-dog dog dogs puppy puppies pup mutt mutts hound hounds lab labs labrador
    husky huskies pug pugs beagle beagles poodle poodles bulldog bulldogs terrier
    terriers chihuahua chihuahuas retriever retrievers)
  (pet-bird bird birds parakeet parakeets parrot parrots canary canaries)
  (pet-fish fish goldfish)
  (pet-other rabbit rabbits gerbil gerbils hamster hamsters guinea lizard lizards snake snakes)
  ))
   
;; 	Do you have a pet at home ?
;;	(have-a-pet)
;; 	from-have-a-pet-input
;;	(0 I do not have a pet 0)  (0 my pet is 0)
;;		gist question: (2 do 1 have 1 pet 3)
	

(READRULES '*specific-answer-from-have-a-pet-input*
  '(
  1 (0 have 2 pet-types 0)
     2 ((My pet is 4 \.)  (from-have-a-pet-input)) (0 :gist)
  1 (0 own 2 pet-types 0)
     2 ((My pet is 4 \.)  (from-have-a-pet-input)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (from-have-a-pet-input)) (0 :gist)
  1 (0 ? 0)
     2 ((Gist \.)  (from-have-a-pet-input)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-have-a-pet-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-have-a-pet-input*
  '(

  ))
		
 (READRULES '*question-from-have-a-pet-input*
  '(
  1 (0 what 2 you 0)
     2 (Do you have a pet at home ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (Do you have a pet at home ?) (0 :gist)
	1 (0 ? 0)
     2 (Do you have a pet at home ?) (0 :gist)
  ))

(READRULES '*reaction-to-have-a-pet-input*
  '( 
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
  1 (0 ? 0)
     2 (Out \.) (100 :out)
	))
); end of eval-when
