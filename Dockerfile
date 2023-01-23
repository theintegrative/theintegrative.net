FROM klakegg/hugo:0.107.0-ext-ubuntu-onbuild
RUN apt update && apt upgrade -y && apt install rsync -y
