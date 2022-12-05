#!/bin/bash -l
#SBATCH --job-name=test_image
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8gb
#SBATCH --time=0-00:10:00
#SBATCH --gres=gpu:1
#SBATCH --account=OD-219033

#SBATCH -o logs/inference/job-%j.out
#SBATCH -e logs/inference/job-%j.err

module load miniconda3/4.9.2
source activate /datasets/work/mlaifsp-st-d61/work/gri317/envs/yolov7

cd /datasets/work/mlaifsp-st-d61/work/gri317/repos/yolov7
# python detect.py --weights weights/yolov7.pt --conf 0.25 --img-size 640 --source inference/images/bushwalk/image/1624325294-920693335.png
python detect.py --weights runs/train/yolov7-e6e-bs64e150-fromscratch-rect/weights/best.pt --conf 0.10 --iou-thres 0.3 --img-size 1024 --save-txt --save-conf --source /datasets/work/mlaifsp-st-d61/work/gri317/datasets/bushwalk_dataset/images/test/1623370489-765419840.png