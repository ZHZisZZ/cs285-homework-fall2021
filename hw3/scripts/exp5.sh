#!/bin/bash
export PYTHONPATH=.

ntu=10
ngsptu=10

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp5/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q5_*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

python cs285/scripts/run_hw3_actor_critic.py \
    --env_name InvertedPendulum-v2 --ep_len 1000 --discount 0.95 -n 100 -l 2 -s 64 -b 5000 -lr 0.01 \
    --exp_name q5_${ntu}_${ngsptu} -ntu ${ntu} -ngsptu ${ngsptu} >> $LOG_PATH

python cs285/scripts/run_hw3_actor_critic.py \
    --env_name HalfCheetah-v2 --ep_len 150 --discount 0.90 --scalar_log_freq 1 -n 150 -l 2 -s 32 -b 30000 -eb 1500 -lr 0.02 \
    --exp_name q5_${ntu}_${ngsptu} -ntu ${ntu} -ngsptu ${ngsptu} >> $LOG_PATH


# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q5_*' 2> /dev/null) $EXP_DIR
