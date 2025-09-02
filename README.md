# Python CI/CD Pipeline with Docker 🚀

[![CI - Python Tests](https://github.com/saeedmfat/python-basic-ci/actions/workflows/ci.yml/badge.svg)](https://github.com/saeedmfat/python-basic-ci/actions/workflows/ci.yml)
[![Docker Build](https://github.com/saeedmfat/python-basic-ci/actions/workflows/docker.yml/badge.svg)](https://github.com/saeedmfat/python-basic-ci/actions/workflows/docker.yml)
[![GitHub Package](https://img.shields.io/badge/GHCR-Package-blue?logo=github)](https://github.com/saeedmfat/python-basic-ci/pkgs/container/python-basic-ci)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue?logo=python)](https://python.org)
[![Docker](https://img.shields.io/badge/Docker-Multi--arch-blue?logo=docker)](https://docker.com)

A modern Python CI/CD pipeline demonstrating GitHub Actions best practices with automated testing, linting, security scanning, and multi-architecture Docker builds.

## 📦 Features

### ✅ Task 3: CI Testing Pipeline
- **🤖 Automated Testing**: Runs pytest on multiple Python versions (3.8, 3.9, 3.10, 3.11)
- **🎯 Code Quality**: Flake8 linting with PEP8 compliance
- **✨ Code Formatting**: Black and isort formatting checks
- **⚡ Smart Caching**: Optimized dependency caching for faster workflows
- **🔍 Pull Request Integration**: Automatic checks on every PR

### 🐳 Task 4: Docker Pipeline
- **📦 Containerization**: Docker image building with best practices
- **🛡️ Security Scanning**: Trivy vulnerability scanning (source code + container images)
- **🏗️ Multi-Architecture**: Builds for both `linux/amd64` and `linux/arm64`
- **📚 GHCR Integration**: Automatic pushes to GitHub Container Registry
- **🔒 Security Integration**: SARIF reports in GitHub Security tab

## 🏗️ Project Structure

```
.
├── app/
│   └── calculator.py          # Sample calculator module
├── tests/
│   └── test_calculator.py     # Pytest test cases
├── .github/
│   └── workflows/
│       ├── ci.yml            # Task 3: CI testing workflow
│       └── docker.yml        # Task 4: Docker build workflow
├── Dockerfile                # Multi-stage Dockerfile
├── requirements-test.txt     # Test dependencies
└── .trivyignore             # Trivy ignore rules
```

## ⚙️ Setup & Usage

### Local Development
```bash
# Clone repository
git clone https://github.com/saeedmfat/python-basic-ci.git
cd python-basic-ci

# Install dependencies
pip install -r requirements-test.txt

# Run tests
pytest -v

# Run linters
flake8 . --max-line-length=127
black --check --line-length 127 .
```

### Using the Docker Image
```bash
# Pull the image
docker pull ghcr.io/saeedmfat/python-basic-ci:latest

# Run tests (default CMD)
docker run ghcr.io/saeedmfat/python-basic-ci:latest

# Run with shell access
docker run -it ghcr.io/saeedmfat/python-basic-ci:latest sh
```

## 📊 Workflows

### 🔄 CI Testing Workflow (`ci.yml`)
**Triggers**: On every push and pull request  
**Jobs**:
1. **Test Matrix**: Runs pytest across Python 3.8, 3.9, 3.10, 3.11
2. **Linting**: Flake8, Black, and isort code quality checks

### 🐳 Docker Build Workflow (`docker.yml`)
**Triggers**: On push to main branch  
**Jobs**:
1. **Security Scan**: Trivy source code vulnerability scanning
2. **Multi-arch Build**: Builds Docker images for amd64/arm64
3. **Image Scan**: Trivy container vulnerability scanning

## 🛡️ Security Features

- **🔍 Trivy Scanning**: Comprehensive vulnerability detection
- **📋 SARIF Reports**: GitHub Security tab integration
- **🚫 .trivyignore**: Managed vulnerability exceptions
- **🔐 GITHUB_TOKEN**: Secure authentication with GHCR

## 🌐 Multi-Architecture Support

The Docker image supports multiple architectures:
- `linux/amd64` - Standard servers and cloud instances
- `linux/arm64` - Apple Silicon, Raspberry Pi, AWS Graviton


```mermaid
flowchart TD
    subgraph "Developer Workflow"
        A[Local Development] -->|git push| B[GitHub Repository]
        A -->|git pull-request| C[Pull Request]
    end

    subgraph "GitHub Actions CI/CD Pipeline"
        B --> D[Trigger Workflows]
        C --> D
        
        subgraph "Task 3: CI Testing Pipeline (ci.yml)"
            E[CI Workflow Trigger]
            E --> F[Set up Job Matrix<br>Python 3.8, 3.9, 3.10, 3.11]
            
            F --> G[Run Tests Job]
            G --> G1[Checkout Code]
            G1 --> G2[Set up Python]
            G2 --> G3[Cache Dependencies]
            G3 --> G4[Install Dependencies]
            G4 --> G5[Run pytest]
            
            F --> H[Linting Job]
            H --> H1[Checkout Code]
            H1 --> H2[Set up Python]
            H2 --> H3[Install Linters]
            H3 --> H4[Run flake8]
            H3 --> H5[Run black]
            H3 --> H6[Run isort]
        end

        subgraph "Task 4: Docker Pipeline (docker.yml)"
            I[Docker Workflow Trigger]
            
            I --> J[Security Scan Job]
            J --> J1[Checkout Code]
            J1 --> J2[Run Trivy FS Scan]
            J2 --> J3[Upload SARIF Results]
            
            I --> K[Multi-arch Build Job]
            K --> K1[Checkout Code]
            K1 --> K2[Set up QEMU]
            K2 --> K3[Set up Buildx]
            K3 --> K4[Login to GHCR]
            K4 --> K5[Extract Metadata]
            K5 --> K6[Build & Push<br>linux/amd64, linux/arm64]
            
            I --> L[Image Scan Job]
            L --> L1[Checkout Code]
            L1 --> L2[Login to GHCR]
            L2 --> L3[Run Trivy Image Scan]
            L3 --> L4[Upload SARIF Results]
        end
    end

    subgraph "Artifacts & Outputs"
        M[Test Results &<br>Code Coverage]
        N[GHCR Container Registry<br>Multi-arch Images]
        O[Security Reports<br>in GitHub Security Tab]
        P[Build Status Badges]
    end

    G5 --> M
    H4 & H5 & H6 --> M
    K6 --> N
    J3 & L4 --> O
    E & I --> P

    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#f3e5f5
    style E fill:#fff3e0
    style I fill:#fff3e0
    style G fill:#e8f5e8
    style H fill:#e8f5e8
    style J fill:#ffebee
    style K fill:#e8f5e8
    style L fill:#ffebee
    style M fill:#f3e5f5
    style N fill:#bbdefb
    style O fill:#ffcdd2
    style P fill:#fff9c4
```

```bash
# Deploy to any Docker-supported environment
docker run -d \
  --name python-app \
  ghcr.io/saeedmfat/python-basic-ci:latest
```

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

**⭐ Star this repo if you found it useful!**