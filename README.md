Assignments for [Berkeley CS 285: Deep Reinforcement Learning, Decision Making, and Control](http://rail.eecs.berkeley.edu/deeprlcourse/).

## Usage
Make sure to **only clone main branch** since the repository contains an orphan `data` branch.
```
$ git clone -b main --single-branch git@github.com:ZHZisZZ/cs285-homework-fall2021.git
```

## Selected Visualizations
### HW1 - Dagger
<p align="middle">
  <img src="https://github.com/ZHZisZZ/cs285-homework-fall2021/blob/data/selected_gif/hw1/dagger-HalfCheetah.gif" width="200" /> 
</p>

```
$ cd hw1
$ sh scripts/dagger.sh
$ tensorboard --logdir data
```

### HW2 - Policy Gradient
<p align="middle">
  <img src="https://github.com/ZHZisZZ/cs285-homework-fall2021/blob/data/selected_gif/hw2/pg-HalfCheetah.gif" width="400" /> 
</p>

```
$ cd hw2
$ PYTHONPATH=. python cs285/scripts/run_hw2.py \
    --env_name HalfCheetah-v2 --ep_len 150 \
    --discount 0.95 -n 101 -l 2 -s 32 -b 30000 -lr 0.02 -rtg --nn_baseline \
    --exp_name q4_b30000_r$0.02_rtg_nnbaseline \
    --video_log_freq 10
$ tensorboard --logdir data
```

### HW3 - DQN
<p align="middle">
  <img src="https://github.com/ZHZisZZ/cs285-homework-fall2021/blob/data/selected_gif/hw3/dqn-MsPacman-v0.gif" width="400" /> 
</p>
<p align="middle">
  <img src="https://github.com/ZHZisZZ/cs285-homework-fall2021/blob/data/selected_gif/hw3/dqn-PongNoFrameskip-v4.gif" width="400" /> 
</p>

**Note**:  `wrap_deepmind` needs to be modified for RGB rendering. 

```
$ PYTHONPATH=. python cs285/scripts/run_hw3_dqn.py \
    --env_name MsPacman-v0 --exp_name q1_mspacman \
    --video_log_freq 500000

$ PYTHONPATH=. python cs285/scripts/run_hw3_dqn.py \
    --env_name PongNoFrameskip-v4 --exp_name q1_pong \
    --video_log_freq 500000

# tensorboard --logdir data
```