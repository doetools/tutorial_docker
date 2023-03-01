FROM ubuntu:20.04 as opencl-runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
        ocl-icd-libopencl1 \
        clinfo && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility


FROM opencl-runtime as opencl-dev

## opencl development tools headers
RUN apt-get update && apt-get install -y --no-install-recommends \
        ocl-icd-opencl-dev

## general development essentials like headers, like gcc headers
RUN apt install build-essential -y --no-install-recommends

## now start installing python
FROM opencl-dev as opencl-python

## better to use ARG or RUN ...
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# locales to UTF-8
RUN apt-get install locales && \
    locale-gen && /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y python3.8 python3-pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

RUN update-alternatives --set python /usr/bin/python3.8 

RUN apt-get update && apt-get install -y python3.8-venv

ENV LANG=en_US.UTF-8

## finally installing python library pyopencl
RUN pip3 install pyopencl












