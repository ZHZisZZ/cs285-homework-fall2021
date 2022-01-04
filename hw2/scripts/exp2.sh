#!/bin/bash
export PYTHONPATH=.

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp2/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q2_*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

# hyperparameters
for b in 5000 1000 500; do
    for r in 5e-3 5e-2 1e-2; do
    python cs285/scripts/run_hw2.py --env_name InvertedPendulum-v2 \
        --ep_len 1000 --discount 0.9 -n 100 -l 2 -s 64 -b $b -lr $r -rtg \
        --eval_batch_size 1000 \
        --exp_name q2_b${b}_r${r} &
    done
    wait
done

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q2_*' 2> /dev/null) $EXP_DIR
