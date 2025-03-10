# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install pytest  # Ensure pytest is installed

# Expose port 5000
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
