#!/bin/zsh
# Exit if setup is not complete
cd diffusers/examples/textual_inversion
if [ ! -f ".setup" ]
then
    echo "Please run install.zsh first."
    exit 1
fi
CWD=$(pwd)
# Loading a clean shell status
cd
source .zshrc
cd $CWD
# Asking the user for the variables
echo "> Enter the model name (from huggingface, example: runwayml/stable-diffusion-v1-5):"
echo "(Leave it empty to use the default model: runwayml/stable-diffusion-v1-5)"
read MODEL_NAME
if [ -z "$MODEL_NAME" ]
then
    MODEL_NAME="runwayml/stable-diffusion-v1-5"
fi

echo "> Enter the source images directory (example: $HOME/textual_inversion/training):"
echo "(Leave it empty to use the default data directory: $HOME/textual_inversion/training)"
read DATA_DIR
if [ -z "$DATA_DIR" ]
then
    DATA_DIR="$HOME/textual_inversion/training"
    # Creating the data directory if it doesn't exist
    if [ ! -d "$DATA_DIR" ]
    then
        mkdir -p $DATA_DIR
    fi
fi
echo "> Enter the placeholder token (example: mask):"
read PLACEHOLDER_TOKEN
echo "> Enter the initializer token (example: toy):"
read INITIALIZER_TOKEN
echo "> Enter the output directory (example: $HOME/textual_inversion/output):"
echo "(Leave it empty to use the default output directory: $HOME/textual_inversion/output)"
read OUTPUT_DIR
if [ -z "$OUTPUT_DIR" ]
then
    OUTPUT_DIR="$HOME/textual_inversion/output"
    # Creating the output directory if it doesn't exist
    if [ ! -d "$OUTPUT_DIR" ]
    then
        mkdir -p $OUTPUT_DIR
    fi
fi
# Allows to set advanced options
RESOLUTION=512
TRAINING_STEPS=3000
BATCH_SIZE=1
GRADIENT_ACCUMULATION_STEPS=4
echo "> Do you want to set advanced options? (y/n)"
read ADVANCED_OPTIONS
if [ "$ADVANCED_OPTIONS" = "y" ]
then
    echo "> Enter the resolution (leave blank for 512):"
    read RESOLUTION
    if [ -z "$RESOLUTION" ]
    then
        RESOLUTION=512
    fi
    echo "> Enter the training steps (leave blank for 3000):"
    read TRAINING_STEPS
    if [ -z "$TRAINING_STEPS" ]
    then
        TRAINING_STEPS=3000
    fi
    echo "> Enter the batch size (leave blank for 1):"
    read BATCH_SIZE
    if [ -z "$BATCH_SIZE" ]
    then
        BATCH_SIZE=1
    fi
    echo "> Enter the gradient accumulation steps (leave blank for 4):"
    read GRADIENT_ACCUMULATION_STEPS
    if [ -z "$GRADIENT_ACCUMULATION_STEPS" ]
    then
        GRADIENT_ACCUMULATION_STEPS=4
    fi
fi
# Launch the training
export MODEL_NAME=$MODEL_NAME
echo "MODEL_NAME=$MODEL_NAME"
export DATA_DIR=$DATA_DIR
echo "DATA_DIR=$DATA_DIR"
export PLACEHOLDER_TOKEN=$PLACEHOLDER_TOKEN
echo "PLACEHOLDER_TOKEN=$PLACEHOLDER_TOKEN"
export INITIALIZER_TOKEN=$INITIALIZER_TOKEN
echo "INITIALIZER_TOKEN=$INITIALIZER_TOKEN"
export OUTPUT_DIR=$OUTPUT_DIR
echo "OUTPUT_DIR=$OUTPUT_DIR"
export RESOLUTION=$RESOLUTION
echo "RESOLUTION=$RESOLUTION"
export TRAINING_STEPS=$TRAINING_STEPS
echo "TRAINING_STEPS=$TRAINING_STEPS"
export BATCH_SIZE=$BATCH_SIZE
echo "BATCH_SIZE=$BATCH_SIZE"
export GRADIENT_ACCUMULATION_STEPS=$GRADIENT_ACCUMULATION_STEPS
echo "GRADIENT_ACCUMULATION_STEPS=$GRADIENT_ACCUMULATION_STEPS"
zsh train.zsh