#!/bin/bash
set -e

# --- Airflow ---
AIRFLOW_VERSION=3.3.2
PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
pip install --user "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
pip install --user "apache-airflow-providers-postgres"

# --- Postgres ---
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib
sudo service postgresql start
sudo -u postgres psql -c "CREATE USER airflow_user WITH PASSWORD 'airflow_pass';" || true
sudo -u postgres psql -c "CREATE DATABASE airflow_lab_db OWNER airflow_user;" || true

mkdir -p /workspaces/airflow-lab/dags /workspaces/airflow-lab/logs /workspaces/airflow-lab/plugins

echo "Setup complete."