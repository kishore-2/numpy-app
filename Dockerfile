# Use an official Python runtime as the base image
FROM python:3.11-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any necessary dependencies from the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

# Command to run the Python script or application
CMD ["python", "hello.py"]
