####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM openjdk:8

RUN apt update && \
    apt-get install -y curl && \
    apt upgrade --yes && \
    apt install ssh openssh-server --yes

# Setup common SSH key.
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/shared_rsa -C common && \
    cat ~/.ssh/shared_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Setup HDFS/Spark resources here
ENV HADOOP_VERSION 3.3.6
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin

RUN curl -O https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar -xzvf hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/ && \
    mv /usr/local/hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm hadoop-$HADOOP_VERSION.tar.gz

RUN MKDIR /usr/local/hdfs/namenode/data
RUN MKDIR /usr/local/hdfs/datanode/data

ADD ./config-files/core-site.xml $HADOOP_HOME/etc/hadoop/
ADD ./config-files/hdfs-site.xml $HADOOP_HOME/etc/hadoop/