ARG BASE_IMAGE=dddlab/base-scipy:v20200228-18f2534-94fdd01b492f
FROM $BASE_IMAGE

LABEL maintainer="Sang-Yun Oh <syoh@ucsb.edu>"

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
        "jupytext==1.3.0" \
        cvxpy \
        nltk \
        quandl \ 
        altair vega_datasets && \
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

