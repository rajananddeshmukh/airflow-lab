#!/bin/bash
set -e

# Start Postgres
sudo service postgresql status || sudo service postgresql start

# Start Airflow standalone in the background, only if not already running
if ! pgrep -f "airflow standalone" > /dev/null; then
  nohup airflow standalone > /workspaces/airflow-lab/airflow_home/standalone.log 2>&1 &
  echo "Airflow standalone starting in background. Logs: airflow_home/standalone.log"
else
  echo "Airflow standalone already running."
fi