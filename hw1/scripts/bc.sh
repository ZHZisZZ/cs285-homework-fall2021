#!/bin/bash
video_log_freq=5
eval_batch_size=10000
num_agent_train_steps_per_iter=5000

# save log and hyperparameters
log_dir=data/log
log_path=${log_dir}/bc_log_`date +%Y-%m-%d_%H-%M-%S`.txt
mkdir -p data/log; touch $log_path
cat $0 >> $log_path
echo "\n\n" >> $log_path

for env in Ant Humanoid Walker2d HalfCheetah Hopper
do 
    python -m cs285.scripts.run_hw1 \
        --expert_policy_file cs285/policies/experts/${env}.pkl \
        --env_name ${env}-v2 --exp_name bc_${env} --n_iter 1 \
        --expert_data cs285/expert_data/expert_data_${env}-v2.pkl \
        --eval_batch_size ${eval_batch_size} \
        --num_agent_train_steps_per_iter ${num_agent_train_steps_per_iter} \
        --video_log_freq ${video_log_freq} >> $log_path
done
