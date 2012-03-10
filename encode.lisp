;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:jsun)

(defgeneric encode (source))

;;; complex

(defun encode-pair (key value)
  (join "'" (string-downcase (symbol-name key)) "':" (encode value)))

(defun encode-hash (hash)
  (join "{" (apply #'join-by "," (loop for pair in (group hash 2) collect (apply #'encode-pair pair))) "}"))

(defun encode-array (array)
  (join "[" (apply #'join-by "," (loop for element in array collect (encode element))) "]"))

(defun hash-like? (source)
  (and (evenp (length source))
       (every #'keywordp (mapcar #'first (group source 2)))))

;;; simple

(defmethod encode (source)
  (format nil "\"[ JSUN failed encoding ~a ]\"" (type-of (car source))))

(defmethod encode ((source number))
  source)

(defmethod encode ((source string))
  (flet ((translate (source)
           (dolist (conversion '(("\\" "\\\\") ("\\n" "\\n") ("\"" "\\\"")))
             (setf source (regex-replace-all (first conversion) source (second conversion))))
           source))
    (join "\"" (translate source) "\"")))

(defmethod encode ((source symbol))
  (encode (string-downcase (symbol-name source))))

(defmethod encode ((source list))
  (if (hash-like? source)
      (encode-hash source)
      (encode-array source)))

(defmethod encode ((source condition))
  (encode (format nil "~a" source)))