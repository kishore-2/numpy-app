FROM python:3.11-alpine

# Set working directory
WORKDIR /app

# Create .local directory to avoid permission errors
RUN mkdir -p /root/.local && chmod -R 777 /root/.local

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Copy the rest of the app code
COPY . .

CMD ["python", "app.py"]
