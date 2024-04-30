#!/bin/bash

#cd ../..

# custom config
DATA=/home/yash/yash/github_coop/CoOp/DATA/
TRAINER=CoCoOp
# TRAINER=CoOp

DATASET=imagenet_a
SEED=305

CFG=vit_b16_c4_ep10_batch1_ctxv1
# CFG=vit_b16_ep50_ctxv1  # uncomment this when TRAINER=CoOp and DATASET=imagenet
SHOTS=16


DIR=output/evaluation/${TRAINER}/${CFG}_${SHOTS}shots/${DATASET}/seed${SEED}
if [ -d "$DIR" ]; then
    echo "Oops! The results exist at ${DIR} (so skip this job)"
else
    python train.py \
    --root ${DATA} \
    --seed ${SEED} \
    --trainer ${TRAINER} \
    --dataset-config-file configs/datasets/${DATASET}.yaml \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    --model-dir output/eurosat/${TRAINER}/${CFG}_${SHOTS}shots/seed${SEED} \
    --load-epoch 50 \
    --eval-only
fi