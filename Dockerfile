FROM ubuntu
MAINTAINER Sam Zaydel "szaydel@gmail.com"

RUN echo "rtconf:x:411:411:System Management User,,,:/home/rtconf:/bin/bash" >> /etc/passwd
RUN echo "rtconf:*:15709:0:99999:7:::" >> /etc/shadow
RUN echo "rtconf:x:411:" >> /etc/group
RUN mkdir -p /home/rtconf/.ssh; mkdir -p /home/rtconf/jenkins; mkdir -p /home/rtconf/.jenkins
ADD ./.ssh /home/rtconf/.ssh
RUN ls -al /home/rtconf
RUN chmod 700 /home/rtconf/.ssh && chmod 400 /home/rtconf/.ssh/id_rsa

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get --no-install-recommends install -q -y openjdk-7-jre-headless openssh-client sudo

ADD http://mirrors.jenkins-ci.org/war/latest/jenkins.war /home/rtconf/jenkins/jenkins.war
RUN chown -R rtconf:rtconf /home/rtconf

EXPOSE 8080

CMD ["sudo", "-u", "rtconf", "java", "-jar", "/home/rtconf/jenkins/jenkins.war"]
