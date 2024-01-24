#!/bin/bash
export JAVA_HOME=/usr/local/openjdk-8/jre

####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Setup HDFS/Spark worker here

service ssh start
$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start datanode