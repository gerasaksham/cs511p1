#!/bin/bash

####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

# Exchange SSH keys.
/etc/init.d/ssh start
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/shared_rsa
ssh-copy-id -i ~/.ssh/id_rsa -o 'IdentityFile ~/.ssh/shared_rsa' -o StrictHostKeyChecking=no -f worker1
ssh-copy-id -i ~/.ssh/id_rsa -o 'IdentityFile ~/.ssh/shared_rsa' -o StrictHostKeyChecking=no -f worker2

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################

# Start HDFS/Spark main here

service ssh start
#/usr/local/hadoop/sbin/start-dfs.sh
$HADOOP_HOME/bin/hdfs --daemon start namenode
sleep 10
$HADOOP_HOME/bin/hdfs --daemon start datanode

# # Keep the container running

spark-class org.apache.spark.deploy.master.Master --host $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT &
sleep 10
#/usr/local/spark/sbin/start-worker.sh $SPARK_MASTER
spark-class org.apache.spark.deploy.worker.Worker -m 2G -c 1 $SPARK_MASTER &
#bash /usr/local/spark/sbin/start-worker.sh -m 2G -c 1 spark://main:7077
tail -f /dev/null
