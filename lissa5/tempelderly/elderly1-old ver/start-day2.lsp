;;
;; Day 1
;;
(setf *mode* nil)
(setq *ttt-addr* "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")

(setf *root-dir* *default-pathname-defaults*)

;================================
;    Rochester 1
;================================

(setf *temp-dir* "elderly/Rochester1")
;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/Rochester1/"))
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)

;================================
;    Rochester 2
;================================

(setf *temp-dir* "elderly/Rochester2")
;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/Rochester2/"))
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)

;================================
;    Family
;================================

(setf *temp-dir* "elderly/Family")
;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/Family/"))
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)


;================================
;    Tell me about yourself
;================================

(setf *temp-dir* "elderly/TellMeAboutYou")
;(setq path (pathname "C:/inetpub/wwwroot/RocSpeakRafayet/lissa5/elderly/TellMeAboutYou/"))
(setf *default-pathname-defaults* (pathname (chdir (make-pathname :directory *temp-dir*))))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)
