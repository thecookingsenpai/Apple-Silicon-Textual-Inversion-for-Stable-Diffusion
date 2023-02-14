#!/bin/zsh
CWD=$(pwd)
# Loading a clean shell status
cd
source .zshrc
cd $CWD
# Downloading diffusers
echo "This package contains a slightly modified version of the diffusers repository."
echo "The repository has been downloaded 14/02/2023 (14 February 2023)."
echo "Do you want to download the last diffusers repository?"
echo "> Warning: this may cause problems as the modifications could break some stuff (y/n)"
read DOWNLOAD_DIFFUSERS
if [ "$DOWNLOAD_DIFFUSERS" = "y" ]
then
    echo "> Downloading diffusers...a copy of the tested version is stored here for reference: diffusers_old"
    mv diffusers diffusers_old
    git clone https://github.com/huggingface/diffusers
fi
cd diffusers
pip install .
# Installing requirements
cd examples/textual_inversion
pip install -r requirements.txt
# Fixing single token errors by commenting out the lines that raise the error (dirty but works)
sed -i 's/if len(token_ids) > 1:/#if len(token_ids) > 1:/' textual_inversion.py
sed -i 's/raise ValueError("The initializer token must be a single token.")/#raise ValueError("The initializer token must be a single token.")/' textual_inversion.py
# Ask the user for the accelerate configuration
echo ">> You will be now asked to enter the accelerate configuration. <<"
echo ">> Please SELECT MPS as a backend. <<"
sleep 5
accelerate config
# Creating the launch prototype file
CWD=$(pwd)
echo "#!/bin/zsh" > train.zsh
echo "cd $CWD" >> train.zsh
launch_cmd='''
accelerate launch textual_inversion.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --train_data_dir=$DATA_DIR \
  --learnable_property="object" \
--placeholder_token="<$PLACEHOLDER_TOKEN>" --initializer_token=“$INITIALIZER_TOKEN"\
--resolution=RESOLUTION \
  --train_batch_size=$BATCH_SIZE \
  --gradient_accumulation_steps=$GRADIENT_ACCUMULATION_STEPS \
  --max_train_steps=$TRAINING_STEPS \
  --learning_rate=5.0e-04 --scale_lr \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --output_dir=$OUTPUT_DIR
'''
echo $launch_cmd > train.zsh
echo "complete" >> .setup
# Configuring huggingface
echo ">> You will be now asked to enter your huggingface token. <<"
echo ">> If you don't have one, you can create one here: https://huggingface.co/settings/tokens <<"
sleep 5
huggingface-cli login
echo ">> Setup complete. <<"