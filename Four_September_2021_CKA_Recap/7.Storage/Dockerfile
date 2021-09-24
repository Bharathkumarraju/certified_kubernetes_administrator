FROM ubuntu:18.04

LABEL Version=1.0

LABEL Name=bkr

RUN  apt-get -y install python --no-install-recommends

RUN pip install flask flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run 

CMD ["test"]

EXPOSE 5000 
