FROM python:3.8-slim-buster

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libopencv-core-dev \
    libglib2.0-0 \
    # for SVM
    libsm6 libxrender1 libxext-dev \
    # tools
    make unzip

COPY requirements.txt /app/
RUN pip install --no-cache -r requirements.txt

ADD https://raw.githubusercontent.com/max747/fgojunks/master/pageinfo/pageinfo.py /app/

# 必要なファイルだけ COPY する
COPY *.py Makefile /app/
COPY data /app/data

RUN make prepare
