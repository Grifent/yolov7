#!/bin/bash -l
#SBATCH --job-name=yolov7_train_e10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=32gb
#SBATCH --time=0-01:00:00
#SBATCH --gres=gpu:1
#SBATCH --account=OD-219033

#SBATCH -o logs/job-%j.out
#SBATCH -e logs/job-%j.err

## Setup environment
module load miniconda3/4.9.2
source activate /datasets/work/mlaifsp-st-d61/work/gri317/envs/yolov7
cd $SCRATCH1DIR/repos/yolov7

## Run
python train_aux.py --workers 8 --device 0 --batch-size 4 --epochs 3 --cache-images --data data/coco.yaml --img 640 640 --cfg cfg/training/yolov7-e6e.yaml --weights 'yolov7-e6e_training.pt' --name yolov7-e6e --hyp data/hyp.scratch.p6.yaml
# python -m torch.distributed.launch --nproc_per_node 2 --master_port 9527 train_aux.py --workers 8 --device 0,1 --sync-bn --epochs 3 --batch-size 8 --data data/coco.yaml --img 1280 1280 --cfg cfg/training/yolov7-e6e.yaml --weights '' --name yolov7-e6e --hyp data/hyp.scratch.p6.yaml