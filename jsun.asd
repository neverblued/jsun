;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:jsun-system
  (:use #:common-lisp #:asdf))

(in-package #:jsun-system)

(defsystem "jsun"
  :description "S-JSON codec"
  :version "0.2"
  :author "Demetrius Conde <condemetrius@gmail.com>"
  :depends-on (#:blackjack #:cl-ppcre)
  :serial t
  :components ((:file "jsun")))
