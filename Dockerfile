FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
RUN useradd hello
USER hello
COPY app.py .

CMD ["python", "app.py"]