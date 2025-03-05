#!/bin/bash

RUN_DIR="${HOME}"
MINICONDA_DIR=${HOME}/miniforge3
VENV=alstracker
export ALSTRACKER_MOGP=${HOME}/mogp_reference_model.pkl

cd $RUN_DIR

NAME=ALS_Tracker
USER=${USER}
GROUP=$(id -gn ${GID})
WORKERS=1
WORKER_CLASS=uvicorn.workers.UvicornWorker
BIND=unix:${RUN_DIR}/gunicorn.sock
LOG_LEVEL=error

source ${MINICONDA_DIR}/etc/profile.d/conda.sh
conda activate $VENV

exec gunicorn ALSTracker.main:app \
  --name "$NAME" \
  --workers "$WORKERS" \
  --worker-class "$WORKER_CLASS" \
  --user="$USER" \
  --group="$GROUP" \
  --bind="$BIND" \
  --log-level="$LOG_LEVEL" \
  --log-file=-
