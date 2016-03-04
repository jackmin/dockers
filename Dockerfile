# This is a docker file for basic build environment using gcc
FROM ubuntu:latest
MAINTAINER Jack MIN <jack.min@ericsson.com>
COPY sources.list.elx /etc/apt/sources.list
RUN apt-get update && apt-get install -y build-essential git vim exuberant-ctags cscope openssh-server autoconf gdb gdb-doc zsh-static
RUN mkdir /var/run/sshd
RUN echo 'root:r00tme' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN chsh -s /bin/zsh root
#RUN wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O /root/install.sh && chmod +x /root/install.sh && /root/install.sh && echo $?

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#
ENV NOTVISIBLE "in users profile"
ENV TERM "xterm-256color"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales
RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

#COPY .vimrc /root/
#COPY .git-prompt.sh /root/
#COPY .prompt.sh /root/
COPY .gitconfig /root/

COPY install.sh /root/
RUN chmod +x /root/install.sh && /root/install.sh
RUN sed -i 's/ZSH_THEME=.*/ZSH_THEME="kolo"/g' /root/.zshrc

RUN git clone https://github.com/jackmin/vimrc.git ~/.vim_runtime
RUN sh ~/.vim_runtime/install_awesome_vimrc.sh
RUN cp -vf ~/.vim_runtime/example/my_configs.vim.example ~/.vim_runtime/my_configs.vim
#COPY my_configs.vim /root/.vim_runtime/

#RUN echo ". ~/.prompt.sh" >> /root/.bashrc

#
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
