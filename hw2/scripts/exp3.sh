#!/bin/bash
export PYTHONPATH=.

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp3/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q3_*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

python cs285/scripts/run_hw2.py \
    --env_name LunarLanderContinuous-v2 --ep_len 1000 \
    --discount 0.99 -n 100 -l 2 -s 64 -b 40000 -lr 0.005 \
    --reward_to_go --nn_baseline --exp_name q3_b40000_r0.005

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q3_*' 2> /dev/null) $EXP_DIR
