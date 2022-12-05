#!/bin/bash -l
#SBATCH --job-name=yolov7_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48gb
#SBATCH --time=0-02:00:00
#SBATCH --gres=gpu:1
#SBATCH --account=OD-219033

#SBATCH -o logs/test/job-%j.out
#SBATCH -e logs/test/job-%j.err

## Setup environment
module load miniconda3/4.9.2
source activate /datasets/work/mlaifsp-st-d61/work/gri317/envs/yolov7
cd /datasets/work/mlaifsp-st-d61/work/gri317/repos/yolov7

## Run
# python test.py --data data/bushwalk.yaml --img 1024 --batch 32 --conf 0.001 --iou 0.65 --device 0 --weights weights/yolov7-e6e.pt --name yolov7_640_val
python test.py --data data/bushwalk.yaml --img 1024 --batch 16 --conf 0.001 --iou 0.65 --task val --device 0 --weights runs/train/yolov7-e6e-bs16e100/weights/best.pt --name yolov7_e6e-bs16e100
# can try --task val, test, speed or study