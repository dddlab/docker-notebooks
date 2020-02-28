ARG BASE_IMAGE=debian
FROM $BASE_IMAGE

RUN apt-get update \
    && apt-get install -y --no-install-recommends cowsay \
    && rm -rf /var/lib/apt/lists/*
ENV PATH "$PATH:/usr/games"

RUN echo HIHI "$BASE_CONTAINER"

ENTRYPOINT ["cowsay"]
CMD ["Hello, There!"]
