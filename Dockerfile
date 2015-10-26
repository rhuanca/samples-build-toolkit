FROM 32bit/ubuntu:14.04
ADD ./ti-sdk-omapl138-lcdk-01.00.00 /root/ti-sdk-omapl138-lcdk-01.00.00
ADD ./samples /root/samples

# setup omapl138 devkit
RUN echo "export TI_SDK_PATH=/root/ti-sdk-omapl138-lcdk-01.00.00" >> /root/.bashrc
RUN echo "source /root/ti-sdk-omapl138-lcdk-01.00.00/linux-devkit/environment-setup" >> /root/.bashrc

# update
RUN apt-get update

# install cmake
RUN apt-get install -y cmake

# setup sshd
RUN apt-get install -y openssh-server
RUN echo 'root:root123' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

