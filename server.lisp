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

;; HTML-site
(defun homepage ()
  (concatenate 'string
               "<!DOCTYPE html>"
               "<html lang='de'>"
               "<head>"
               "<meta charset='UTF-8'>"
               "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
               "<title>homepage</title>"
               "<style>"
               "body { font-family: Arial, sans-serif; margin: 0; padding: 0; text-align: center; background-color: white; color: black; overflow: hidden; }"
               "#canvas-bg { position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; z-index: -1; }"
               "h1 { margin-top: 20vh; font-size: 3rem; position: relative; z-index: 1; }"
               ".links a { display: inline-block; margin: 10px; padding: 10px 20px; background: rgba(0,0,0,0.6); color: white; text-decoration: white; border-radius: 5px; }"
               "</style>"
               "</head>"
               "<body>"
               "<canvas id='canvas-bg'></canvas>"
               "<h1>Welcome!</h1>"
               "<div class='links'>"
               "<a href='https://github.com/svndin' target='_blank'>GitHub</a>"
               "<a href='https://linkedin.com/' target='_blank'>LinkedIn</a>"
               "<a href='github.com' target='_blank'>Message Me</a>"
               "</div>"
               "</body></html>"))


;; Handler registration
(define-easy-handler (hello :uri "/") () (homepage))

;; server instance
(defparameter *server*
  (make-instance 'hunchentoot:easy-acceptor
                 :port 8080))

;; start server
(hunchentoot:start *server*)

(format t "Lisp-Webserver on Port 8080~%")

;; prevent SBCL from exiting to keep the container running
(loop (sleep 10))
