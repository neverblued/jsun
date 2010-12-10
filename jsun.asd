(defpackage #:jsun-system
  (:use
     #:common-lisp
     #:asdf
     )
  )

(in-package #:jsun-system)

(defsystem "jsun"
  :description "S-JSON codec"
  :version "0.1"
  :author "Demetrius Conde <condemetrius@gmail.com>"
  :licence "Public Domain"
  :depends-on (#:cl-ppcre)
  :serial t
  :components ((:file "jsun")))
