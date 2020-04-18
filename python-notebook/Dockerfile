ARG BASE_IMAGE=dddlab/base-scipy:v20200228-18f2534-94fdd01b492f
FROM $BASE_IMAGE

LABEL maintainer="Sang-Yun Oh <syoh@ucsb.edu>"

USER root

RUN apt-get update && \
    apt-get install -y \
        libxtst-dev \
        zsh \
        powerline \
        fonts-powerline \
        less \
        bsdmainutils

USER $NB_USER

RUN \
    # Notebook extensions (TOC extension)
    pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --sys-prefix && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable toggle_all_line_numbers/main --sys-prefix && \
    jupyter nbextension enable table_beautifier/main --sys-prefix && \
    \
    # jupyter lab extensions
    jupyter labextension install @jupyterlab/toc --clean && \
    \
    # remove cache
    rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN \
    pip install \
        pandas==1.0.3 \
        cvxpy \
        nltk \
        quandl \ 
        altair vega_datasets \
        otter-grader \
        ipympl && \
    \
    rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN \
    pip install ipywebrtc && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-webrtc --clean
    # face_recognition 
    #conda install -c menpo dlib && \

RUN \
    pip install --upgrade jupyterlab-git && \
    \
    jupyter nbextension enable export_embedded/main --sys-prefix && \
    \
    pip install nbzip && \
    jupyter serverextension enable nbzip --py --sys-prefix && \
    jupyter nbextension install nbzip --py --sys-prefix && \
    jupyter nbextension enable nbzip --py --sys-prefix && \
    \
    jupyter lab build

RUN \
    ## Jupyter Classic Notebook Extensions
    jupyter nbextensions_configurator enable --sys-prefix && \
    \
    pip install --pre rise && \
    jupyter nbextension install rise --py --sys-prefix && \
    jupyter nbextension enable rise --py --sys-prefix && \
    \
    pip install hide_code && \
    jupyter nbextension install --py hide_code --sys-prefix && \
    jupyter nbextension enable --py hide_code --sys-prefix && \
    jupyter serverextension enable --py hide_code --sys-prefix

RUN pip install ipympl && \
    jupyter labextension install jupyter-matplotlib && \
    jupyter labextension update --all && \
    rm -f /opt/conda/share/jupyter/lab/extensions/jupyter-matplotlib-0.4.*

