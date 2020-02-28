ARG BASE_IMAGE=ucsb/base-scipy:v20200111
FROM $BASE_IMAGE

LABEL maintainer="Sang-Yun Oh <syoh@ucsb.edu>"

USER root

# modified from 
# https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/Dockerfile

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-dejavu \
        gfortran \
        gcc \
        psmisc \
        libapparmor1 \
        lsb-release \
        libclang-dev \
        zip unzip \
        tree && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

USER $NB_USER

# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
        'r-base=3.6.1' \
        'r-crayon=1.3*' \
        'r-devtools=2.1*' \
        'r-htmltools=0.3*' \
        'r-irkernel=1.0*' \
        'r-plyr=1.8*' \
        'r-reshape2=1.4*' \
        'r-rmarkdown=1.14*' \
        'r-tidyverse=1.2*' \
        'rpy2=2.9*' && \
    \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

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
