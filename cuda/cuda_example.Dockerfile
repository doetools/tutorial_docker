FROM cuda-latest

WORKDIR /example 

COPY . .

CMD ["python3","cuda_example.py"]