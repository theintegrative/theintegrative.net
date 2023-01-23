FROM ubuntu
COPY . /site
WORKDIR /site
RUN apt update && apt upgrade -y && apt install hugo rsync -y
