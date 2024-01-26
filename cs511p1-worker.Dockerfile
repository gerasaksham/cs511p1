####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM cs511p1-common

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################
# RUN mkdir /usr/local/hdfs/
# RUN mkdir /usr/local/hdfs/datanode
# RUN mkdir /usr/local/hdfs/datanode/data

# ADD ./config-files/hdfs-site.xml $HADOOP_HOME/etc/hadoop/

COPY ./setup-worker.sh ./setup-worker.sh
RUN /bin/bash setup-worker.sh

COPY ./start-worker.sh ./start-worker.sh
CMD ["/bin/bash", "start-worker.sh"]
