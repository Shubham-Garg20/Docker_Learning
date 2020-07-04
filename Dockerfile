FROM python:3.9-rc-alpine3.12
RUN mkdir /app
WORKDIR /app

COPY requirements.txt requirements.txt
EXPOSE 5000
ENV <proxy if any>
RUN apk add --no-cache --virtual .build-deps gcc \
    && pip3 install --proxy <proxy if any> -r requirements.txt \
    && apk del .build-deps

COPY . .

LABEL maintainer="garg" \
      version="1.0"

VOLUME ["/app/public"]

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD python app.py
