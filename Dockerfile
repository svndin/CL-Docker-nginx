# This image is a secure, community-maintained SBCL build by respected Lisp developer. (Debian-Basis)
FROM daewok/sbcl:latest
WORKDIR /app
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --load quicklisp.lisp --eval "(quicklisp-quickstart:install)" --quit && \
    echo '(load "/root/quicklisp/setup.lisp")' > /root/.sbclrc
RUN sbcl --load /root/quicklisp/setup.lisp --eval "(ql:quickload '(:hunchentoot :cl+ssl))" --quit
COPY server.lisp /app/server.lisp
COPY background.js /app/background.js
CMD ["sbcl", "--noinform", "--disable-debugger", "--load", "/app/server.lisp"]
