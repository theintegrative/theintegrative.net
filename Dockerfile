FROM ubuntu
RUN apt update && apt upgrade -y && apt install hugo rsync -y
