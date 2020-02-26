FROM jupyter/scipy-notebook:1386e2046833

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

USER $NB_UID

RUN pip install nbgitpuller okpy && \
    pip install git+https://github.com/okpy/jassign.git && \
    \
    # jupytext
    pip install jupytext && \
    jupyter lab build && \
    \
    # classic notebook vim binding
    git clone https://github.com/lambdalisue/jupyter-vim-binding \
        /opt/conda/share/jupyter/nbextensions/vim_binding && \
    jupyter nbextension disable vim_binding/vim_binding --sys-prefix && \
    \
    # jupyter lab vim binding
    jupyter labextension install jupyterlab_vim --clean && \
    jupyter labextension disable jupyterlab_vim && \
    \
    # remove cache
    rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
