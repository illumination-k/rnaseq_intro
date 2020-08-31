FROM conda/miniconda3

# r-notebookを使うとDESeq2とのconflictが起こる

USER root

RUN apt-get update --fix-missing && \
    apt-get install -y less git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# black background
RUN mkdir -p /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension
RUN echo '{"theme":"JupyterLab Dark"}' > \
        /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

RUN conda update -n base conda 

RUN conda install -c bioconda -c conda-forge -c r \
        jupyterlab \
        r-irkernel \
        bioconductor-deseq2 \
        bioconductor-clusterprofiler \
        bioconductor-org.at.tair.db \
        bioconductor-pathview

RUN pip install \
        pandas \
        numpy \
        matplotlib \
        seaborn \
        scipy \
        scikit-learn \
        clust \
        openpyxl

USER jovyan