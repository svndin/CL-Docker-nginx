;; Load Quicklisp
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

;; load libs
;;(ql:quickload '(:hunchentoot :cl+ssl))
(ql:quickload '(:hunchentoot))

;; define package
(defpackage :simple-server
  (:use :cl :hunchentoot))

(in-package :simple-server)

;; HTML & js-background
(defun homepage ()
  (concatenate 'string
               "<!DOCTYPE html>"
               "<html lang='de'>"
               "<head>"
               "<meta charset='UTF-8'>"
               "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
               "<title>Surface of rotation</title>"
               "<style>"
               "body { font-family: Arial, sans-serif; margin: 0; padding: 0; text-align: center; background-color: black; color: black; overflow: hidden; }"
               "#canvas-bg { position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; z-index: -1; }"
               "h1, p { color: white; font-weight: normal; /* -webkit-text-stroke: 1px black; text-shadow: 1px 1px 0 white, -1px -1px 0 white, 1px -1px 0 white, -1px 1px 0 white;*/ }"
               "h1 { margin-top: 20vh; font-size: 3rem; position: relative; z-index: 1; }"
               ".links a { display: inline-block; margin: 10px; padding: 10px 20px; background: rgba(0,0,0,0.6); text-decoration: none; border-radius: 5px; color: white; font-weight: bold; }"
               "</style>"
               "</head>"
               "<body>"
               "<canvas id='canvas-bg'></canvas>"
               "<h1>Welcome to My Digital Space</h1>"
               "<p><br><br><br>I'm Svndin, a developer and tech enthusiast.<br><br>This is my corner of the internet – feel free to look around!<br><br><br></p>"
               "<div class='links'>"
               "<a href='https://github.com/svndin' target='_blank'>GitHub</a>"
               "<a href='https://linkedin.com/in/' target='_blank'>LinkedIn</a>"
               "<a href='mailto:svndin@github.com' target='_blank'>Message Me</a>"
               "</div>"

               "<script src='/background.js'></script>"

               "</body></html>"))


;; dispatcher for static data
(setf hunchentoot:*dispatch-table*
      (list
       (hunchentoot:create-static-file-dispatcher-and-handler "/background.js" "/app/background.js")
       (hunchentoot:create-prefix-dispatcher "/" #'homepage)))

;; server instance
(defparameter *server*
  (make-instance 'hunchentoot:easy-acceptor
;;                 :address "0.0.0.0"
;;                 :port 80
;;                 :port 443
                 :port 8080
;;                 :ssl-p t
;;                 :cert-file "/etc/nginx/ssl/nginx-selfsigned.crt"
;;                 :key-file "/etc/nginx/ssl/nginx-selfsigned.key"
                 ))

;; start server
(hunchentoot:start *server*)

(format t "Lisp-Webserver on Port 8080~%")

;; prevent SBCL from exiting to keep the container running
(loop (sleep 10))

