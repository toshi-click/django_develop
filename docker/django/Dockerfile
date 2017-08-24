FROM python:2.7
ENV PYTHONUNBUFFERED 1
WORKDIR /core
ADD requirements.txt /core/
RUN pip install -r requirements.txt
ADD . /core/
