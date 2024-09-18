FROM python:3.9-alpine
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
WORKDIR /app
COPY ./bookstore-api.py ./bookstore-api.py
EXPOSE 80
CMD python3 ./bookstore-api.py