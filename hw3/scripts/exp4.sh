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

python cs285/scripts/run_hw3_actor_critic.py --env_name CartPole-v0 -n 100 -b 1000 --exp_name q4_ac_1_1 -ntu 1 -ngsptu 1 &
python cs285/scripts/run_hw3_actor_critic.py --env_name CartPole-v0 -n 100 -b 1000 --exp_name q4_ac_100_1 -ntu 100 -ngsptu 1 &
python cs285/scripts/run_hw3_actor_critic.py --env_name CartPole-v0 -n 100 -b 1000 --exp_name q4_ac_1_100 -ntu 1 -ngsptu 100 &
python cs285/scripts/run_hw3_actor_critic.py --env_name CartPole-v0 -n 100 -b 1000 --exp_name q4_ac_10_10 -ntu 10 -ngsptu 10 &

wait

# move data file to experiment data directory
mv $(find ${DATA_DIR} -maxdepth 1 -name '*q4_*' 2> /dev/null) $EXP_DIR
