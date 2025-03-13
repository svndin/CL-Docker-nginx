# Lisp Server with Docker and Nginx

![Webpage](https://github.com/svndin/CL-Docker-nginx/blob/main/webpage.png)

This project provides a simple web server written in Common Lisp, running with SBCL and Hunchentoot. The server operates inside a Docker container and is secured with an Nginx reverse proxy.

## Project Structure

```
├── [Dockerfile](https://github.com/svndin/CL-Docker-nginx/blob/main/Dockerfile)           # Image for the Lisp server
├── [docker-compose.yml](https://github.com/svndin/CL-Docker-nginx/blob/main/docker-compose.yml)   # Container orchestration
├── [server.lisp](https://github.com/svndin/CL-Docker-nginx/blob/main/server.lisp)          # Main server code in Common Lisp
├── [nginx.conf](https://github.com/svndin/CL-Docker-nginx/blob/main/nginx.conf)           # Configuration for the Nginx proxy
└── [background.js](https://github.com/svndin/CL-Docker-nginx/blob/main/background.js)        # Background animation for the webpage

```

## Features

- **Lisp server with Hunchentoot**: Serves a simple webpage.
- **Docker containerization**: Isolated and secure execution.
- **Nginx proxy**: SSL encryption and security hardening.
- **Optimized performance**: Nginx is hardened for security and efficiency.

## Installation & Startup

### Prerequisites

- Docker and Docker Compose installed

### Start the Server

```sh
docker-compose up --build -d
```

### Stop the Server

```sh
docker-compose down
```

## Security Hardening

- **Nginx**:
  - SSL encryption with TLS 1.2/1.3
  - Hidden server information
  - Strict security headers
  - Restriction of HTTP methods
- **Docker containers**:
  - `no-new-privileges:true`
  - `cap_drop: ALL`
  - `tmpfs` for temporary files

## License

MIT License

---

Enjoy the project! If you have any questions, feel free to reach out via [GitHub](https://github.com/svndin).


