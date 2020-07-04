FROM python:3.9-rc-alpine3.12
RUN mkdir /app
WORKDIR /app

COPY requirements.txt requirements.txt
EXPOSE 5000
ENV http_proxy=http://web-proxy.houston.hpecorp.net:8080
RUN apk add --no-cache --virtual .build-deps gcc \
    && pip3 install --proxy http://web-proxy.houston.hpecorp.net:8080 -r requirements.txt \
    && apk del .build-deps

COPY . .

LABEL maintainer="garg" \
      version="1.0"

VOLUME ["/app/public"]

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD python app.py
