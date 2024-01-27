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

# HDFS 
ENV JAVA_HOME=/usr/local/openjdk-8/jre
ENV PATH $PATH:$JAVA_HOME/bin
ENV HADOOP_VERSION 3.3.6
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
ENV HDFS_DATANODE_USER root
RUN curl -O https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar -xzvf hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/ && \
    mv /usr/local/hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm hadoop-$HADOOP_VERSION.tar.gz

RUN mkdir /usr/local/hdfs/
RUN mkdir /usr/local/hdfs/namenode
RUN mkdir /usr/local/hdfs/datanode
RUN mkdir /usr/local/hdfs/namenode/data
RUN mkdir /usr/local/hdfs/datanode/data

ADD ./conf/core-site.xml $HADOOP_HOME/etc/hadoop/
ADD ./conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
ADD ./conf/hadoop-env.sh $HADOOP_HOME/etc/hadoop/
EXPOSE 9000 50070

# Spark
ENV SPARK_VERSION 3.4.1
ENV SPARK_HOME /usr/local/spark
ENV PATH $SPARK_HOME/bin:$PATH
ENV SPARK_MASTER_HOST main
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER spark://main:7077


RUN curl -O https://archive.apache.org/dist/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3.tgz && \
    tar -xzvf spark-3.4.1-bin-hadoop3.tgz -C /usr/local/ && \
    mv /usr/local/spark-3.4.1-bin-hadoop3 /usr/local/spark && \
    rm spark-3.4.1-bin-hadoop3.tgz

EXPOSE 4040 6066 7077 8080
