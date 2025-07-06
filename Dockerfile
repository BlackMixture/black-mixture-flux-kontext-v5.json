# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.1.0-base

# install custom nodes into comfyui
RUN comfy-node-install rgthree-comfy comfyui_essentials

# download models and put them into the correct folders in comfyui (one RUN per model)
RUN comfy model download --url https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors --relative-path models/text_encoders --filename clip_l.safetensors
RUN comfy model download --url https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/text_encoders --filename t5xxl_fp8_e4m3fn_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Lumina_Image_2.0_Repackaged/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/flux1-kontext-dev_ComfyUI/resolve/main/split_files/diffusion_models/flux1-dev-kontext_fp8_scaled.safetensors --relative-path models/diffusion_models --filename flux1-dev-kontext_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/XLabs-AI/flux-lora-collection/resolve/main/realism_lora.safetensors --relative-path models/loras --filename EXTRAS\flux_realism_lora.safetensors
# RUN # Could not find exact URL for lora_flux_dachinfix.safetensors - found on Civitai but direct download link not available

# copy all input data (like images or videos) into comfyui
COPY input/ /comfyui/input/