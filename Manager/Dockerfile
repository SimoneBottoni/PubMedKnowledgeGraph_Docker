from openjdk:8

USER root
EXPOSE 22/tcp
EXPOSE 22/udp

EXPOSE 8281

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim



# ----------- Config Manager -----------
USER root
RUN useradd -m -s /bin/bash pubmed

RUN mkdir -p /home/pubmed/config
COPY config/*.properties /home/pubmed/config/
RUN chown pubmed /home/pubmed/config

WORKDIR /home/pubmed
USER pubmed
RUN echo 'Downloading Spring Worker..'
RUN wget -nc 'https://storage.googleapis.com/apache-1ecf3.appspot.com/PubMedKnowledgeGraph_Manager-v1.0.jar'
#COPY config/PubMedKnowledgeGraph_Manager-v1.0.jar PubMedKnowledgeGraph_Manager-v1.0.jar



# ----------- Config Manager -----------
USER root
COPY config/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && ln -s /usr/local/bin/entrypoint.sh /
ENTRYPOINT ["entrypoint.sh"]
