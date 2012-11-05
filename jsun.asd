;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:jsun-system
  (:use #:common-lisp #:asdf))

(in-package #:jsun-system)

(defsystem "jsun"
  :description "S-JSON codec"
  :version "0.3"
  :author "Дмитрий Пинский <demetrius@neverblued.info>"
  :depends-on (#:blackjack #:cl-ppcre)
  :serial t
  :components ((:file "package")
               (:file "encode")))
