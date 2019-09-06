FROM continuumio/miniconda3:4.5.11

COPY requirements_pip.txt /
RUN pip install -r /requirements_pip.txt


#COPY requirements_conda.txt /
#RUN conda install --yes \
#    --file requirements_conda.txt\
#    && conda clean -tipsy

COPY ./ /app

WORKDIR /app
#CMD [ "python3","-u","dispatcher.py" ]
CMD [ "python3","-u","dispatcher.py" ]

endpoints --prefix=controllers --host=localhost:8000
