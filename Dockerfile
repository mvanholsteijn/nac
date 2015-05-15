FROM mvanholsteijn/wrk
ADD next_available_consultants.sh /
RUN chmod +x /next_available_consultants.sh

ENTRYPOINT ["/next_available_consultants.sh"]

