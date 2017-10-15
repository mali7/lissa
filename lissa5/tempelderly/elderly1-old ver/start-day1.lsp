;;
;; Day 1
;;

;in the new dialogues take care of 
;./input.lisp
;./output.txt
;(load "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")


(setf *mode* nil)
(setq *ttt-addr* "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")

(setf *root-dir* *default-pathname-defaults*)

;================================
;    Getting to know you
;================================

(setf *temp-dir* "elderly/GettingToKnow")
;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/GettingToKnow/"))
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)


;================================
;    Where are you from
;================================

(setf *temp-dir* "elderly/WhereAreYouFrom")
;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/WhereAreYouFrom/"))
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)

;================================
;    Activities you like to do
;================================

;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/Activities/"))
(setf *temp-dir* "elderly/Activities")
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)


;================================
;    Friends
;================================

;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/Friends/"))
(setf *temp-dir* "elderly/Friends")
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)
