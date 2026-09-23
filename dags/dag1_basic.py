from airflow.sdk import dag, task
from airflow.providers.standard.operators.empty import EmptyOperator
from datetime import datetime


@dag(
    dag_id="dag1_basic_start_print_end",
    schedule=None,          # no automatic schedule — we trigger it manually
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["basics"],
)
def dag1_basic():

    start = EmptyOperator(task_id="start")

    @task
    def print_line():
        print("Hello from Airflow — this task ran successfully.")

    end = EmptyOperator(task_id="end_task")

    start >> print_line() >> end


dag1_basic()