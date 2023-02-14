# Apple Silicon Textual Inversion for Stable Diffusion diffusers

## Introduction

Please note that this work is experimental and made mainly for myself.
It is distributed without any warranty and is to be considered just a simple way to make textual inversion work on macOS powered by Apple Silicon with ease.

All the credits go to huggingface for the original diffusers repository which is cloned and slightly modified in this package.

Stable Diffusion and any model that you may use are distributed under their own terms and conditions.

## What it is and what it is not

This work is:

- An easy way to set up your own textual inversion toolkit without wasting hours resolving hiccups
- A small experiment to see how Apple Silicon works with diffusers

And is not:

- A fork of diffusers
- The most stable and updated diffusers implementation
- An apple
- Anything else

## How to

Clone this repository, cd in it from the terminal and run:

    zsh install.zsh

Ideally, you should stick with the included diffusers version as it is tested (on a M1 Max machine) and stable but you can choose to update diffusers during the setup process.

Once finished, you can run:

    zsh launch.zsh

And answer the questions to train a model.
