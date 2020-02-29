ARG BASE_IMAGE=dddlab/base-scipy-rstudio:v20200228-18f2534-94fdd01b492f
FROM $BASE_IMAGE

USER root
RUN sudo apt-get update && \
    sudo apt-get install -y time cmake

USER $NB_USER

RUN \
    # Notebook extensions (TOC extension)
    pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --sys-prefix && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable toggle_all_line_numbers/main --sys-prefix && \
    jupyter nbextension enable table_beautifier/main --sys-prefix && \
    \
    # Notebook extensions configurator (server on and interface off)
    jupyter nbextension install jupyter_nbextensions_configurator --py --sys-prefix && \
    jupyter nbextensions_configurator disable --sys-prefix && \
    jupyter serverextension enable jupyter_nbextensions_configurator --sys-prefix && \
    \
    # jupyter lab extensions
    jupyter labextension install @jupyterlab/toc --clean && \
    \
    # remove cache
    rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN \
    conda install --quiet --yes 'r-rcppeigen=0.3.3.7.0' && \
    conda install -c menpo dlib && \
    pip install \
        cvxpy nltk quandl ipywebrtc \
        face_recognition jupyter-server-proxy \
        cppimport \
        git+https://github.com/ucsb-pstat/jupyter-rsession-proxy && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-webrtc --clean && \
    \
    # clean up
    rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


