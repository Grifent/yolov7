#!/bin/bash -l
#SBATCH --job-name=yolov7_paramtuning
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=9
#SBATCH --mem=48gb
#SBATCH --time=7-00:00:00
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
python train.py --workers 8 --device 0 --batch-size 16 --epochs 25 --data data/bushwalk.yaml --img 640 640 \
--cfg cfg/training/yolov7x.yaml --weights 'weights/yolov7x_training.pt' --name yolov7x-paramtuning \
--hyp data/hyp.scratch.bushwalk.yaml --evolve
