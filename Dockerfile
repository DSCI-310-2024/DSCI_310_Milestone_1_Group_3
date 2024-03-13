FROM quay.io/jupyter/r-notebook:2023-11-19

RUN conda install -y \
    r-cowplot=1.1.3 \
    r-essentials=4.3 \
    r-ggally=2.2.1 \
    r-islr=1.4 \
    r-kknn=1.3.1 \
    r-repr=1.1.6