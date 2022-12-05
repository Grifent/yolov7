#!/bin/bash -l
#SBATCH --job-name=yolov7_train_fromscratch_ota
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=4
#SBATCH --mem=64gb
#SBATCH --time=2-00:00:00
#SBATCH --gres=gpu:2
#SBATCH --account=OD-219033

#SBATCH -o logs/train/job-%j.out
#SBATCH -e logs/train/job-%j.err

## Setup environment
module load miniconda3/4.9.2
source activate /datasets/work/mlaifsp-st-d61/work/gri317/envs/yolov7
cd /datasets/work/mlaifsp-st-d61/work/gri317/repos/yolov7

## Run (default port 12345, bs = nodes*gpus_per_node*base_batch_size(4))
srun sh -c "python train_aux_ddp.py --workers 8 --port 12111 \
--device 0,1 --sync-bn --epochs 150 --batch-size 64 --data data/bushwalk.yaml --img 1024 1024 --cfg cfg/training/yolov7-e6e.yaml \
--weights '' --name yolov7-e6e-bs64e150-fromscratch-ota --hyp data/hyp.scratch.bushwalk.yaml"

# --weights 'weights/yolov7-e6e_training.pt'