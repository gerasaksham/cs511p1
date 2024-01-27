#!/bin/bash

####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

/etc/init.d/ssh start
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/shared_rsa

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Start HDFS/Spark worker here
$HADOOP_HOME/bin/hdfs --daemon start datanode
sleep 30
spark-class org.apache.spark.deploy.worker.Worker -m 2G -c 2 $SPARK_MASTER &
tail -f /dev/null