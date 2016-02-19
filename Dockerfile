# This is a docker file for basic build environment using gcc
FROM ubuntu:latest
MAINTAINER Jack MIN <jack.min@ericsson.com>
COPY sources.list.elx /etc/apt/sources.list
RUN apt-get update && apt-get install -y build-essential git vim exuberant-ctags cscope openssh-server autoconf gdb gdb-doc
RUN mkdir /var/run/sshd
RUN echo 'root:r00tme' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY .vimrc /root/
COPY .git-prompt.sh /root/
COPY .prompt.sh /root/
COPY .gitconfig /root/

RUN echo ". ~/.prompt.sh" >> /root/.bashrc

#
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
