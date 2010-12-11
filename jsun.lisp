(defpackage #:jsun
  (:use #:common-lisp)
  (:import-from #:bin #:join)
  (:import-from #:bin #:join-by)
  (:import-from #:bin #:group)
  (:import-from #:cl-ppcre #:regex-replace-all)
  )

(in-package #:jsun)

(defgeneric encode (source))

;;; complex

(defun encode-pair (key value)
  (join "'" (string-downcase (symbol-name key)) "':" (encode value)))

(defun encode-hash (hash)
  (join "{" (apply #'join-by "," (loop for pair in (group hash 2) collect (apply #'encode-pair pair))) "}"))

(defun encode-array (array)
  (join "[" (apply #'join-by "," (loop for element in array collect (encode element))) "]"))

(defun hashlike? (source)
  (and (evenp (length source))
       (every #'keywordp (mapcar #'first (group source 2)))))

;;; simple

(defmethod encode (source)
  (format nil "\"[ Cannot encode ~a to JSON! ]\"" (type-of source)))

(defmethod encode ((source number))
  source)

(defmethod encode ((source string))
  (flet ((translate (source)
           (dolist (token '("\\n" "\\\""))
             (setf source (regex-replace-all token source token)))
           source))
    (join "\"" (translate source) "\"")))

(defmethod encode ((source list))
  (if (hashlike? source)
      (encode-hash source)
      (encode-array source)))
