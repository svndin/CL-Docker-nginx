FROM daewok/sbcl:latest
WORKDIR /app
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --load quicklisp.lisp --eval "(quicklisp-quickstart:install)" --quit
RUN echo '(load "/root/quicklisp/setup.lisp")' > /root/.sbclrc
RUN sbcl --load /root/quicklisp/setup.lisp --eval "(ql:quickload '(:hunchentoot :cl+ssl))" --quit
COPY server.lisp /app/server.lisp
EXPOSE 8080
CMD ["sbcl", "--script", "/app/server.lisp"]
