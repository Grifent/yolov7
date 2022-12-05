#!/bin/bash -l
#SBATCH --job-name=test_image
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16gb
#SBATCH --time=0-10:00:00
#SBATCH --gres=gpu:1
#SBATCH --account=OD-219033

#SBATCH -o logs/job-%j.out
#SBATCH -e logs/job-%j.err

## Setup environment
module load miniconda3/4.9.2
source activate /datasets/work/mlaifsp-st-d61/work/gri317/envs/yolov7
cd /datasets/work/mlaifsp-st-d61/work/gri317/repos/yolov7

## Run
python test.py --data data/coco.yaml --img 640 --batch 32 --conf 0.001 --iou 0.65 --device 0 --weights yolov7.pt --name yolov7_640_val