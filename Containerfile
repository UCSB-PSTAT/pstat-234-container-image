FROM ucsb/jupyter-base:latest

MAINTAINER LSIT Systems <lsitops@lsit.ucsb.edu>

USER root

RUN apt-get update && \
    apt-get install -y texlive-full python3-dev libbz2-dev libxt-dev nano && \
    apt-get clean

RUN pip install otter-grader \
    seaborn \
    scipy \
    scikit-learn \
    matplotlib \
    Scrapy

RUN mamba install -c conda-forge jupyterlab_rise altair

ENV TZ America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN export QUARTO_VERSION=$(curl https://github.com/quarto-dev/quarto-cli |grep -Po '(?<=releases/tag/v).*(?=">)') && \
    mkdir -p /opt/quarto/ && \
    curl -o quarto.tar.gz -L "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"  && \
    tar -zxvf quarto.tar.gz -C "/opt/quarto" --strip-components=1 && \
    ln -s /opt/quarto/bin/quarto /usr/local/bin/quarto && \
    rm -f quarto.tar.gz && \
    quarto install tinytex --update-path


RUN /usr/local/bin/fix-permissions "${CONDA_DIR}" || true

USER $NB_USER
