############# DEPENDENCIES ###############
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.models import Variable
from datetime import datetime, timedelta
import requests

############# DAG ###############

# DAG
my_dag = DAG(
    dag_id='metkapinezic_wg_model',
    description='World of Worships Blitz data model',
    tags=['takehome', 'test'],
    schedule_interval='0 0 * * *', #daily
    catchup=False,
    default_args={
        'owner': 'airflow',
        'start_date': datetime(2024, 2, 26),
    }
)

############# DEFINE TASKS ############### 

# TASK 1: Stage Tables
def stage_tables(**kwargs):
    # refresh stage tables
    pass

# TASK 2: Quality Check Stage
def quality_check_stage(**kwargs):
    # quality checks for each stage table
    pass
 
# TASK 3: Update Mart User Activity
def user_activity(**kwargs):
    # create table insert into user activity
    pass
 
# TASK 4: Quality Checks Passed
def quality_checks_passed(**kwargs):
    # run quality queries and inform if not passed
    pass


############# CREATE TASK ###############


# Create Task 1: stage_tables
stage_tables = PythonOperator(
    task_id='stage_tables',
    python_callable=stage_tables,
    provide_context=True,  
    dag=my_dag,
)

# Create Task 2: quality_check_stage
quality_check_stage = PythonOperator(
    task_id="quality_check_stage",
    python_callable=quality_check_stage,
    provide_context=True,
    dag=my_dag,
)

# Create Task 3: update_mart_user_activity
update_mart_user_activity = PythonOperator(
    task_id='user_activity',
    python_callable=update_mart_user_activity,
    provide_context=True,
    dag=my_dag,
)


# Create Task 4: quality_checks_passed
quality_checks_passed = PythonOperator(
    task_id='quality_checks_passed',
    python_callable=quality_checks_passed,
    provide_context=True,
    dag=my_dag,
)


############# DAG DESIGN ###############

stage_tables >> quality_check_stage >> user_activity >> quality_checks_passed
