# https://hub.docker.com/r/library/python/tags/
FROM python:3-alpine

# Coping source in current directory into the image
# python:3-onbuild expects the source in /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN pip install -r requirements.txt
ENV ENV=test
# Commands in a list
CMD ["python", "api.py"]
