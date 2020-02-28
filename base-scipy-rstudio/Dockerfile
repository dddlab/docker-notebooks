ARG BASE_IMAGE=dddlab/base-scipy:20200228-7fcac48-1386e2046833
FROM $BASE_IMAGE

LABEL maintainer="Sang-Yun Oh <syoh@ucsb.edu>"

USER root

# modified from 
# https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile
#### start
# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc && \
    rm -rf /var/lib/apt/lists/*

# Fix for devtools https://github.com/conda-forge/r-devtools-feedstock/issues/4
RUN ln -s /bin/tar /bin/gtar

USER $NB_UID

# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-base=3.6.2' \
    'r-caret=6.0*' \
    'r-crayon=1.3*' \
    'r-devtools=2.2*' \
    'r-forecast=8.10*' \
    'r-hexbin=1.28*' \
    'r-htmltools=0.4*' \
    'r-htmlwidgets=1.5*' \
    'r-irkernel=1.1*' \
    'r-nycflights13=1.0*' \
    'r-plyr=1.8*' \
    'r-randomforest=4.6*' \
    'r-rcurl=1.98*' \
    'r-reshape2=1.4*' \
    'r-rmarkdown=2.1*' \
    'r-rsqlite=2.1*' \
    'r-shiny=1.3*' \
    'r-tidyverse=1.3*' \
    'rpy2=3.1*' \
    && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install e1071 R package (dependency of the caret R package)
RUN conda install --quiet --yes r-e1071
#### end

# Rstudio Pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        psmisc \
        libapparmor1 \
        lsb-release \
        libclang-dev \
        zip unzip \
        tree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ENV PATH=$PATH:/usr/lib/rstudio-server/bin \
    R_HOME=/opt/conda/lib/R
ARG LITTLER=$R_HOME/library/littler

RUN \
    # download R studio
    curl --silent -L --fail https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.2.1578-amd64.deb > /tmp/rstudio.deb && \
    echo '81f72d5f986a776eee0f11e69a536fb7 /tmp/rstudio.deb' | md5sum -c - && \
    \
    # install R studio
    apt-get update && \
    apt-get install -y --no-install-recommends /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    \
    # setting default CRAN mirror
    echo "local({\n" \
         "   r <- getOption('repos')\n" \
         "   r['CRAN'] <- 'https://cloud.r-project.org'\n" \
         "   options(repos = r)\n" \
         "})\n" > $R_HOME/etc/Rprofile.site && \
    \
    # littler provides install2.r script
    R -e "install.packages(c('littler', 'docopt'))" && \
    \
    # modifying littler scripts to conda R location
    sed -i 's/\/usr\/local\/lib\/R\/site-library/\/opt\/conda\/lib\/R\/library/g' \
        ${LITTLER}/examples/*.r && \
	ln -s ${LITTLER}/bin/r ${LITTLER}/examples/*.r /usr/local/bin/ && \
	echo "$R_HOME/lib" | sudo tee -a /etc/ld.so.conf.d/littler.conf && \
	ldconfig && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
    
USER $NB_USER

RUN pip install jupyter-server-proxy && \
    pip install git+https://github.com/ucsb-pstat/jupyter-rsession-proxy && \
    \
    # remove cache
    rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
