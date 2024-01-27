####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM cs511p1-common

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################
#ADD ./config-files/main/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
# RUN mkdir /usr/local/hdfs/
# RUN mkdir /usr/local/hdfs/namenode
# RUN mkdir /usr/local/hdfs/namenode/data
# ADD ./config-files/main/hdfs-site.xml $HADOOP_HOME/etc/hadoop/

COPY ./setup-main.sh ./setup-main.sh
RUN /bin/bash setup-main.sh

COPY ./start-main.sh ./start-main.sh
CMD ["/bin/bash", "start-main.sh"]

