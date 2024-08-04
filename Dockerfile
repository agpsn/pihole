#docker buildx build --no-cache --pull --tag agpsn/pihole:latest .
FROM pihole/pihole:latest
COPY root/* /

RUN /bin/bash /install.sh && rm -f /install.sh
RUN /bin/bash /install2.sh && rm -f /install2.sh

VOLUME ["/config"]
