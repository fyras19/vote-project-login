# Use Python base image
FROM python:3.13-rc-slim

# Set the working directory in the container
WORKDIR /app

# Copy and install requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy all necessary files and directories
COPY . .

# Expose port 5000 
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]