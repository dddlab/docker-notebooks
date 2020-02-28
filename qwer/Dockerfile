ARG BASE_CONTAINER=debian
FROM $BASE_CONTAINER

RUN apt-get update \
    && apt-get install -y --no-install-recommends cowsay \
    && rm -rf /var/lib/apt/lists/*
ENV PATH "$PATH:/usr/games"

RUN echo HIHI "$BASE_CONTAINER"

ENTRYPOINT ["cowsay"]
CMD ["Hello, There!"]
