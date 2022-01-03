#!/bin/bash
export PYTHONPATH=.

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp4/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q4_*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

for b in 10000 30000 50000; do
    for r in 0.005 0.01 0.02; do
    python cs285/scripts/run_hw2.py --env_name HalfCheetah-v2 --ep_len 150 \
        --discount 0.95 -n 100 -l 2 -s 32 -b ${b} -lr ${r} -rtg --nn_baseline \
        --exp_name q4_search_b${b}_lr${r}_rtg_nnbaseline >> $LOG_PATH
    done
done

# python cs285/scripts/run_hw2.py --env_name HalfCheetah-v2 --ep_len 150 \
#     --discount 0.95 -n 100 -l 2 -s 32 -b <b*> -lr <r*> \
#     --exp_name q4_b<b*>_r<r*>

# python cs285/scripts/run_hw2.py --env_name HalfCheetah-v2 --ep_len 150 \
#     --discount 0.95 -n 100 -l 2 -s 32 -b <b*> -lr <r*> -rtg \
#     --exp_name q4_b<b*>_r<r*>_rtg

# python cs285/scripts/run_hw2.py --env_name HalfCheetah-v2 --ep_len 150 \
#     --discount 0.95 -n 100 -l 2 -s 32 -b <b*> -lr <r*> --nn_baseline \
#     --exp_name q4_b<b*>_r<r*>_nnbaseline

# python cs285/scripts/run_hw2.py --env_name HalfCheetah-v2 --ep_len 150 \
#     --discount 0.95 -n 100 -l 2 -s 32 -b <b*> -lr <r*> -rtg --nn_baseline \
#     --exp_name q4_b<b*>_r<r*>_rtg_nnbaseline

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q4_*' 2> /dev/null) $EXP_DIR
