FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04
WORKDIR /app
RUN apt-get update && apt-get install -y python3-pip git && rm -rf /var/lib/apt/lists/*
COPY . .
RUN pip3 install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cu121
RUN pip3 install --no-cache-dir gradio diffusers transformers accelerate
# السطر السحري لحل مشكلة الموديولات المفقودة
ENV PYTHONPATH=/app
CMD ["python3", "-c", "import sys; sys.path.append('/app'); import inference"]
RUN pip3 install --no-cache-dir gradio diffusers transformers accelerate loguru
