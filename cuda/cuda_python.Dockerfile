FROM nvidia/cuda:11.2.0-devel-ubuntu18.04
# FROM nvidia/cuda:10.2-devel-ubuntu18.04 as cuda-python

RUN apt-get update

## install python and pip
RUN apt-get install -y python3.8 python3-pip

## development packages
RUN apt-get install build-essential

## Ubuntu 18.04 only allows for Python 3.6.9
## can check the python version by
## CMD python3 --version

RUN pip3 install numpy

## therefore install pycuda 2017.1.1
RUN pip3 install pycuda==2017.1.1


## install venv
RUN apt-get install -y python3-venv

