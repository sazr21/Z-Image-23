# استخدام نسخة Ubuntu مزودة بـ CUDA لدعم كرت الشاشة
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

WORKDIR /app

# تثبيت Python والمتطلبات الأساسية
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# نسخ جميع ملفات المشروع إلى الحاوية
COPY . .

# تثبيت المكتبات المطلوبة (PyTorch والمكتبات الأخرى)
RUN pip3 install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cu121
RUN pip3 install --no-cache-dir -r requirements.txt || pip3 install --no-cache-dir gradio diffusers transformers accelerate

# منفذ التشغيل لواجهة المستخدم
EXPOSE 7860

# أمر التشغيل (تأكد من أن الملف الرئيسي هو inference.py أو قم بتغييره لملف التشغيل الخاص بك)
CMD ["python3", "inference.py"]
