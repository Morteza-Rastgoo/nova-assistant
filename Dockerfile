FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pyproject.toml .
COPY backend/app ./app

# Install Python dependencies
RUN pip install --no-cache-dir pip-tools
RUN pip install --no-cache-dir .

# Create directory for TTS files and download voice model
RUN mkdir -p app/tts_files
RUN apt-get update && apt-get install -y wget \
    && wget -O app/tts_files/voices-v1.0.bin https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0/voices-v1.0.bin \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]