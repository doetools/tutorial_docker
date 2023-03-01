FROM opencl-python

WORKDIR /example

COPY . .

CMD ["python3","opencl_example.py"]