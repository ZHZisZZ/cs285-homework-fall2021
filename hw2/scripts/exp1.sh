#!/bin/bash
export PYTHONPATH=.

DATA_DIR=./data
EXP_DIR=${DATA_DIR}/exp1/`date +%Y-%m-%d_%H-%M-%S`
LOG_PATH=${EXP_DIR}/log.txt
# clear other data files
rm -rf $(find ${DATA_DIR} -maxdepth 1 -name '*q1_*' 2> /dev/null)
# create data directory for this experiment and logfile
mkdir -p $EXP_DIR; touch $LOG_PATH
# dump experiment commands and hyperparameters (this file) to logfile
cat $0 >> $LOG_PATH; echo "\n\n" >> $LOG_PATH

python cs285/scripts/run_hw2.py --env_name CartPole-v0 -n 100 -b 1000 \
    -dsa --exp_name q1_sb_no_rtg_dsa --eval_batch_size 1000 &

python cs285/scripts/run_hw2.py --env_name CartPole-v0 -n 100 -b 1000 \
    -rtg -dsa --exp_name q1_sb_rtg_dsa --eval_batch_size 1000 &

python cs285/scripts/run_hw2.py --env_name CartPole-v0 -n 100 -b 1000 \
    -rtg --exp_name q1_sb_rtg_na --eval_batch_size 1000 &

python cs285/scripts/run_hw2.py --env_name CartPole-v0 -n 100 -b 5000 \
    -dsa --exp_name q1_lb_no_rtg_dsa --eval_batch_size 1000 &

python cs285/scripts/run_hw2.py --env_name CartPole-v0 -n 100 -b 5000 \
    -rtg -dsa --exp_name q1_lb_rtg_dsa --eval_batch_size 1000 &

python cs285/scripts/run_hw2.py --env_name CartPole-v0 -n 100 -b 5000 \
    -rtg --exp_name q1_lb_rtg_na --eval_batch_size 1000 &
    
wait

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q1_*' 2> /dev/null) $EXP_DIR
