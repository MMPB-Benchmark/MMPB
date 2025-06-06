#!/bin/bash

models=(
    "llava-onevision-qwen2-7b-ov-hf"
    "Ovis2-8B"
    "Qwen2-VL-7B-Instruct"
    "Qwen2.5-VL-7B-Instruct"
    "Ovis2-16B"
    # "llava_v1.5_13b"
    # "InternVL2_5-8B-MPO"
)

injection_prompt_location=("2" "4" "5" "6" "8" "end")

for model in "${models[@]}"; do
    for loc in "${injection_prompt_location[@]}"; do
        echo "Running model: $model, prompt type: $prompt_type, conversation turns: $turn"
        torchrun --nproc-per-node=4 run.py --data MMPB --model "$model" --verbose --generic_conversation_n_turn 10 --injection_prompt_location "$loc" --wandb_exp_name new_lim_result
    done
done

for model in "${models[@]}"; do
    for loc in "${injection_prompt_location[@]}"; do
        echo "Running model: $model, prompt type: $prompt_type, conversation turns: $turn"
        torchrun --nproc-per-node=4 run.py --data MMPB --model "$model" --prompting_methods remind_zero_shot --verbose --generic_conversation_n_turn 10 --injection_prompt_location "$loc" --wandb_exp_name new_lim_result
    done
done
