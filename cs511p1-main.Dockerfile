####################################################################################
# DO NOT MODIFY THE BELOW ##########################################################

FROM cs511p1-common

# DO NOT MODIFY THE ABOVE ##########################################################
####################################################################################
FROM sequenceiq/hadoop-docker:latest

COPY ./setup-main.sh ./setup-main.sh
RUN chmod +x setup-main.sh

COPY ./start-main.sh ./start-main.sh
CMD ["/bin/bash", "start-main.sh"]
