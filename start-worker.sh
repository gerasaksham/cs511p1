#!/bin/bash

####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

/etc/init.d/ssh start
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/shared_rsa

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Start HDFS/Spark worker here
$HADOOP_HOME/bin/hdfs datanode
sleep 10

spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER