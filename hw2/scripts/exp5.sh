#!/bin/bash
export PYTHONPATH=.

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp5/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q5_*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

for lambda in 0 0.95 0.99 1; do
    python cs285/scripts/run_hw2.py \
        --env_name Hopper-v2 --ep_len 1000
        --discount 0.99 -n 300 -l 2 -s 32 -b 2000 -lr 0.001 \
        --reward_to_go --nn_baseline --action_noise_std 0.5 --gae_lambda ${lambda} \
        --exp_name q5_b2000_r0.001_lambda${lambda} &
done

wait

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q5_*' 2> /dev/null) $EXP_DIR
