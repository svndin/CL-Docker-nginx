;; Load Quicklisp
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

;; load libs
(ql:quickload '(:hunchentoot :cl+ssl))

;; define package
(defpackage :simple-server
  (:use :cl :hunchentoot))

(in-package :simple-server)

;; simple funktion to print "Hello World!" on :8080
(defun hello-world ()
  "Returns 'Hello World' as HTTP-response."
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hello World!~%"))

;; Handler registration
(define-easy-handler (hello :uri "/") () (hello-world))

;; server instance
(defparameter *server*
  (make-instance 'hunchentoot:easy-acceptor
                 :port 8080))

;; start server
(hunchentoot:start *server*)

(format t "Lisp-Webserver on Port 8080~%")

;; prevent SBCL from exiting to keep the container running
(loop (sleep 10))
