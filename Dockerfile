FROM daewok/sbcl:latest
WORKDIR /app
RUN apt-get update && apt-get upgrade -y > /dev/null 2>&1
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --load quicklisp.lisp --eval "(quicklisp-quickstart:install)" --quit && \
    echo '(load "/root/quicklisp/setup.lisp")' > /root/.sbclrc
RUN sbcl --load /root/quicklisp/setup.lisp --eval "(ql:quickload '(:hunchentoot :cl+ssl))" --quit
ENV SBCL_VERSION="hidden"
ENV HUNCHENTOOT_VERSION="hidden"
COPY server.lisp /app/server.lisp
COPY background.js /app/background.js
EXPOSE 8080
CMD ["sbcl", "--noinform", "--disable-debugger", "--load", "/app/server.lisp"]
