FROM python:3-alpine AS base

RUN addgroup -S app && adduser -S app -G app

WORKDIR /app
COPY requirements.txt .
RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps
COPY app.py .
USER app

CMD [ "python", "./app.py" ]