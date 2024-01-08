FROM ucsb/jupyter-base:latest

MAINTAINER LSIT Systems <lsitops@lsit.ucsb.edu>

USER root

RUN apt-get update && \
    apt-get install -y python3-dev libbz2-dev libxt-dev nano texlive-xetex texlive-fonts-recommended texlive-plain-generic && \
    apt-get clean

RUN pip install otter-grader \
    seaborn \
    scipy \
    scikit-learn \
    matplotlib \
    cvxpy \
    statsmodels \
    umap-learn \
    yfinance
    
RUN mamba install -c conda-forge jupyterlab_rise altair

ENV TZ America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN /usr/local/bin/fix-permissions "${CONDA_DIR}" || true

USER $NB_USER
