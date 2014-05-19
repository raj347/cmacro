(in-package :cl-user)
(defpackage cmacro.pattern
  (:use :cl :anaphora)
  (:import-from :cmacro.token
                :<token>
                :<variable>
                :var-rest-p
                :var-qualifiers
                :list-type
                :var-list-p
                :var-array-p
                :var-block-p
                :var-group-p)
  (:import-from :cmacro.macro
                :<macro-case>
                :case-match))
(in-package :cmacro.pattern)

(defmethod var-p ((token <token>))
  "Is the token a variable?"
  (is (type-of token) '<variable>))

(defmethod match-group ((var <variable>) list)
  "Groups are lists, arrays and blocks. This checks whether var matches list."
  (let ((list-type (list-type list)))
    (when list-type
      (or (var-group-p list)
          (and (var-list-p list) (eq list-type :list))
          (and (var-array-p list) (eq list-type :array))
          (and (var-block-p list) (eq list-type :block))))))
