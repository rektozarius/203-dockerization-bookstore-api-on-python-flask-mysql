FROM python:3.9-alpine
WORKDIR /app
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
COPY . .
EXPOSE 80
CMD python3 ./bookstore-api.py