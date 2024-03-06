FROM python:3.12-slim
WORKDIR /app
COPY . .
RUN python make-data.py
RUN apt-get update && apt-get install -y apache2-utils 
CMD [ "bash","./generate-votes.sh" ]