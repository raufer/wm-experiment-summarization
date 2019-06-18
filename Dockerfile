FROM ubuntu:18.10

LABEL maintainer="Raul Ferreira <raufer92@gmail.com>"

RUN apt-get update -y && \
    apt install build-essential -y && \
    apt-get install vim -y && \
    apt-get install git -y && \
    apt-get install wget -y && \
    apt-get install nginx -y

RUN  apt-get -yq update && \
     apt-get -yqq install ssh

RUN echo 'Setting up Python' && \
    apt-get install python3.6 -y && \
    apt-get install -y libsasl2-dev gcc g++ python3.6-dev -y && \
    apt-get install python3.6-distutils -y && \
    apt-get install build-essential python3.6-dev libkrb5-dev -y && \
    apt-get install python3.6-venv -y && \
    apt-get install curl -y && \
    curl https://bootstrap.pypa.io/get-pip.py | python3.6 - && \
    pip install wheel && \
    pip install poetry

RUN pip3.6 install --upgrade pip wheel 

RUN pip3.6 install -q tf-nightly-gpu-2.0-preview && \
    pip3.6 install -q tensorflow_hub==0.4.0 && \
    pip3.6 install -q jupyterlab && \
    pip3.6 install -q bert-tensorflow==1.0.1 && \
    pip3.6 install -q tqdm==4.31.1 && \
    pip3.6 install -q tensorflow-datasets && \
    pip3.6 install -q ipywidgets==7.4.2

RUN jupyter nbextension enable --py widgetsnbextension

COPY ./ ./app/
WORKDIR ./app

EXPOSE 8888

CMD ["jupyter", "lab","--ip=0.0.0.0","--allow-root"]




