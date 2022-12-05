#!/bin/bash -l
#SBATCH --job-name=yolov7_train_e10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48gb
#SBATCH --time=0-04:00:00
#SBATCH --gres=gpu:1
#SBATCH --account=OD-219033

#SBATCH -o logs/train/job-%j.out
#SBATCH -e logs/train/job-%j.err

## Setup environment
module load miniconda3/4.9.2
source activate /datasets/work/mlaifsp-st-d61/work/gri317/envs/yolov7
cd /datasets/work/mlaifsp-st-d61/work/gri317/repos/yolov7

## Run
# current scaling images to ~half resolution (full is 2016,1512), can use num_workers == batch-size
python train_aux.py --workers 4 --device 0 --batch-size 4 --epochs 2 --data data/bushwalk.yaml --img 1024 1024 \
--cfg cfg/training/yolov7-e6e.yaml --weights 'weights/yolov7-e6e_training.pt' --name yolov7-e6e-paramtuning \
--hyp data/hyp.scratch.bushwalk.yaml --exist-ok
