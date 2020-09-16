ARG BASE_IMAGE=jupyter/scipy-notebook:94fdd01b492f
FROM $BASE_IMAGE

LABEL maintainer="Sang-Yun Oh <syoh@ucsb.edu>"

USER root

RUN \
    git clone https://github.com/TheLocehiliosan/yadm.git \
        /usr/local/share/yadm && \
    ln -s /usr/local/share/yadm/yadm /usr/local/bin/yadm && \
    \
    apt-get update && \
    apt-get install -y vim.tiny wget curl zip unzip file && \
    ln -s $(which vim.tiny) /usr/local/bin/vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

RUN pip install nbgitpuller
