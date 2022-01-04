#!/bin/bash
export PYTHONPATH=.

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp1/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q1*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

python cs285/scripts/run_hw3_dqn.py \
    --env_name MsPacman-v0 --exp_name q1_mspacman \
    --video_log_freq 500000 >> $LOG_PATH

# python cs285/scripts/run_hw3_dqn.py \
#     --env_name PongNoFrameskip-v4 --exp_name q1_pong \
#     --video_log_freq 1000000 >> $LOG_PATH

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q1*' 2> /dev/null) $EXP_DIR
