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

# Create directory for TTS files
RUN mkdir -p app/tts_files

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]