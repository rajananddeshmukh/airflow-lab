#!/bin/bash
set -e
export AIRFLOW_HOME=/workspaces/airflow-lab/airflow_home
mkdir -p "$AIRFLOW_HOME"

AIRFLOW_VERSION=3.3.2
PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

pip install --user "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

echo "export AIRFLOW_HOME=/workspaces/airflow-lab/airflow_home" >> ~/.bashrc
echo "export PATH=\$PATH:~/.local/bin" >> ~/.bashrc