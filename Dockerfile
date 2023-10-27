# Use the official image of Python as base image
FROM python:3.8-slim-buster

# Set environment variables
ENV AIRFLOW_HOME=/opt/airflow
ENV AIRFLOW__CORE__EXECUTOR=SequentialExecutor
ENV AIRFLOW__CORE__SQL_ALCHEMY_CONN=sqlite:////opt/airflow/airflow.db
ENV AIRFLOW__WEBSERVER__SECRET_KEY=secret_key
ENV AIRFLOW__WEBSERVER__AUTHENTICATE=True
ENV AIRFLOW__WEBSERVER__AUTH_BACKEND=airflow.contrib.auth.backends.password_auth

#install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        freetds-bin \
        build-essential \
        libkrb5-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        libpq-dev \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Airflow
RUN pip install apache-airflow

# User root to create te directory
USER root
RUN mkdir -p /opt/airflow && chmod 777 /opt/airflow && \
    mkdir -p /opt/airflow/dags && \
    mkdir -p /opt/airflow/logs && \
    mkdir -p /opt/airflow/plugins

## Copy the DAG 'scraper.py' to the DAGs folder of the container
## Copy the requirements.txt file to the container
## run the command 'pip install -r requirements.txt' to install the dependencies

# Initialize the database
RUN airflow db init && \
    airflow users create \
        --username admin \
        --password admin \
        --firstname admin \
        --lastname admin \
        --role Admin \
        --email admin@mail.com

EXPOSE 8080

CMD ["airflow", "webserver"]
