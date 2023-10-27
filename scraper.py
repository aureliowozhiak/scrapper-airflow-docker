import requests
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 10, 26),
}

dag = DAG(
    'wiki_dag',
    default_args=default_args,
    description='A DAG that retrieves the HTML content of a Wikipedia page',
    schedule_interval=None,
)

def get_wiki_html():
    url = 'https://pt.wikipedia.org/wiki/Python'
    response = requests.get(url).text
    print(response)

get_wiki_html_operator = PythonOperator(
    task_id='get_wiki_html',
    python_callable=get_wiki_html,
    dag=dag,
)

get_wiki_html_operator