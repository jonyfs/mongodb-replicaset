FROM mvertes/alpine-mongo:3.4.10-0

COPY scripts /root/scripts

RUN ls /root/scripts
RUN chmod +x /root/scripts/run.sh

ENTRYPOINT ["/root/scripts/run.sh"]