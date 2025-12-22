FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

COPY . /usr/local/puzzle-box
RUN chown -R vscode:vscode /usr/local/puzzle-box

RUN /usr/local/puzzle-box/core/setup.sh

RUN /usr/local/puzzle-box/langs/assembly/setup.sh
RUN /usr/local/puzzle-box/langs/c/setup.sh
RUN /usr/local/puzzle-box/langs/cpp/setup.sh
RUN /usr/local/puzzle-box/langs/csharp/setup.sh
RUN /usr/local/puzzle-box/langs/go/setup.sh
RUN /usr/local/puzzle-box/langs/java/setup.sh
RUN /usr/local/puzzle-box/langs/javascript/setup.sh
RUN /usr/local/puzzle-box/langs/lisp/setup.sh
RUN /usr/local/puzzle-box/langs/lua/setup.sh
RUN /usr/local/puzzle-box/langs/perl/setup.sh
RUN /usr/local/puzzle-box/langs/python/setup.sh
RUN /usr/local/puzzle-box/langs/rust/setup.sh
RUN /usr/local/puzzle-box/langs/typescript/setup.sh

RUN /usr/local/puzzle-box/core/post_setup.sh

RUN chown -R vscode:vscode /home/vscode
CMD ["/bin/sh", "-c", "source /home/vscode/.bashrc && exec /bin/sh"]

USER vscode
RUN /usr/local/puzzle-box/langs/csharp/post_setup_vscode_user.sh
