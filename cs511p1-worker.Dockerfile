####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM cs511p1-common

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################
FROM sequenceiq/hadoop-docker:latest

COPY ./setup-worker.sh ./setup-worker.sh
RUN chmod +x setup-worker.sh

COPY ./start-worker.sh ./start-worker.sh
CMD ["/bin/bash", "start-worker.sh"]
