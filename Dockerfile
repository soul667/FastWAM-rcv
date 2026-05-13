FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY . /workspace

ARG INSTALL_PROJECT=false
RUN pip install --upgrade pip setuptools wheel && \
    if [ "${INSTALL_PROJECT}" = "true" ]; then \
      pip install torch==2.7.1+cu128 torchvision==0.22.1+cu128 --extra-index-url https://download.pytorch.org/whl/cu128 && \
      pip install -e . ; \
    fi

CMD ["bash"]
