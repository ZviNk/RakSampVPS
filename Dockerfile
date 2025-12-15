FROM node:22.9.0-slim

RUN apt-get update && apt-get install -y tzdata
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wine32 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/crow/RakSamp/Arizona/logs
RUN wine cmd.exe /c echo Z: > Z.bat
RUN echo "/home/crow/RakSamp/Arizona" >> Z.bat
RUN wine regedit Z.bat
RUN rm Z.bat

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

CMD [ "node", "index.js" ]