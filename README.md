# Python CI/CD Docker Project

This project demonstrates a robust CI/CD pipeline implementation using GitHub Actions, featuring both VM based and a Docker containerized testing environments. 
The pipeline automatically runs tests on every push or pull requests to the main branch or can be manually triggered for each branch.

## Project Overview

This project demonstrates:

- Setting up a Python project with dependencies in requirements.txt
- Running tests in a CI pipeline on a Linux VM (ubuntu-latest)
- Building a Docker image and running tests inside the container
- Using GitHub Actions for continuous integration (CI)
- Clean repository management with .gitignore to exclude IDE and environment files

## Features

- Multi environment testing: validates code in both VM and containerised environments
- Dockerized CI/CD: ensures consistent testing across machines
- GitHub Actions workflow:
- Triggered on push to master, pull_request to master, and manually via workflow_dispatch
- Two jobs:
    - VM-based tests 
    - Docker-based tests, dependent on VM tests
- Clean repository: .idea/, .iml, .venv/ excluded

## Repository Structure
```text
python-ci-cd-docker/
├── .github/workflows/ci.yml   # GitHub Actions workflow
├── Dockerfile                 # Docker configuration for testing
├── requirements.txt           # Python dependencies
├── tests/                     # Test files
├── README.md                  # Project documentation
├── .gitignore                 # Ignored files (IDE, Python cache, etc.) 
```
## GitHub Actions Workflow

 Workflow file: .github/workflows/ci.yml 
  - Triggers:
    - push to master 
    - pull_request to master 
    - workflow_dispatch (manual)

## CI/CD Pipeline
GitHub Actions workflow consists of two sequential jobs:
### 1. VM Tests (`vm-tests`)
- Runs on Ubuntu latest
- Sets up Python 3.10 environment
- Installs dependencies from requirements.txt
- Executes pytest test suite
### 2. Docker Tests (`docker-tests`)
- Runs after VM tests pass (dependency chain)
- Builds Docker image from Dockerfile
- Runs tests inside the container
- Ensures consistency across different environments
- 
## Setup Instructions (Local)

Clone the repo using SSH (recommended):
```bash
git clone git@github.com:yourusername/python-ci-cd-docker.git

cd python-ci-cd-docker
```
Create a virtual environment:

Mac/Linux / WSL
```bash
python -m venv .venv
source .venv/bin/activate   # Mac/Linux
```
or 

Windows CMD
```cmd
.venv\Scripts\activate.bat
```
or

Windows PowerShell
```powershell
.venv\Scripts\Activate.ps1
```
Install dependencies:
```bash
pip install -r requirements.txt
```
Run tests locally:
```bash
pytest
```
Build and run Docker container:
```bash
docker build -t ci-cd-demo .
docker run --rm ci-cd-demo
```

## Notes

- IDE files and virtual environments are ignored via .gitignore
- Docker ensures environment consistency for CI/CD 
- Tests are written with pytest, but any Python test framework can be used

## Future Improvements (optional)

- Push Docker images to a container registry (e.g., Docker Hub or GitHub Container Registry)
- Deploy to a cloud platform (AWS ECS, GCP Cloud Run, Azure App Service)
- Add linting, security scanning, and matrix testing for multiple Python versions