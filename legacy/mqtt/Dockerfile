FROM eclipse-mosquitto

COPY entrypoint.sh /entrypoint.sh
COPY config/.passwd /etc/mosquitto/passwd

ENTRYPOINT ["sh", "/entrypoint.sh"]

CMD ["/usr/sbin/mosquitto","-c","/mosquitto/config/mosquitto.conf"]