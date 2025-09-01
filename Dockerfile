FROM python:3.10-slim-bullseye

WORKDIR /app

COPY requirements-test.txt ./

RUN pip install --no-cache-dir -r requirements-test.txt

COPY . .

CMD ["pytest", "-v"]