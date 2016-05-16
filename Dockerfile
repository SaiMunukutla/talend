#
# Oracle Java 8 Dockerfile
#
# https://github.com/cogniteev/docker-oracle-java
# https://github.com/cogniteev/docker-oracle-java/tree/master/oracle-java8
#

# Pull base image.
FROM ubuntu

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install crontabs && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
#/home/ubuntu/my/talend/Couch/Couch_Sync_Data

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#ADD TestCouch2SF_0.1 /data/TestCouch2SF_0.1 
ADD talend /data/talend
# Define default command.
#ENTRYPOINT ["/data/TestCouch2SF_0.1/TestCouch2SF/TestCouch2SF_run.sh"]
#CMD ["sh","/data/TestCouch2SF_0.1/TestCouch2SF/TestCouch2SF_run.sh"]
#CMD ["sh","/data/talend/Couch/Couch_Sync_Data/Couch_Sync_Data_run.sh"]
COPY C2S.zip /
RUN cd / && unzip C2S.zip
#RUN echo 'crontab -e >> * */1 * * * sh /C2S/Sync_Couch_SF/testC2S.sh  2>&1 | mail -s "cron C2S output" vasu.4440@gmail.com'
RUN crontab -l | { cat; echo "* */1 * * * sh /C2S/Sync_Couch_SF/testC2S.sh  2>&1 | mail -s "cron C2S output" vasu.4440@gmail.com"; } | crontab -
