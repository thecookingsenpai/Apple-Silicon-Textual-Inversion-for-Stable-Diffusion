#!/bin/zsh
accelerate launch textual_inversion.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --train_data_dir=$DATA_DIR \
  --learnable_property="object" \
--placeholder_token="<$PLACEHOLDER_TOKEN>" --initializer_token="$INITIALIZER_TOKEN"\
--resolution=RESOLUTION \
  --train_batch_size=$BATCH_SIZE \
  --gradient_accumulation_steps=$GRADIENT_ACCUMULATION_STEPS \
  --max_train_steps=$TRAINING_STEPS \
  --learning_rate=5.0e-04 --scale_lr \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --output_dir=$OUTPUT_DIR