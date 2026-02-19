# Jenkins Deployment on AWS EC2 using Docker

## Objective
Deploy Jenkins on AWS EC2 and demonstrate project and user management.

---

## Tech Stack
- AWS EC2 (Ubuntu 22.04 LTS)
- Docker
- Jenkins (LTS)
- GitHub

---

## Implementation Steps

### 1. EC2 Setup
- Launched Ubuntu 22.04 EC2 instance
- Configured Security Group:
  - Port 22 (SSH)
  - Port 8080 (Jenkins)

---

### 2. Docker Installation

Commands executed:

sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

---

### 3. Jenkins Deployment Using Docker

Command executed:

docker run -d --name jenkins \
-p 8080:8080 \
-p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
jenkins/jenkins:lts

---

### 4. Initial Jenkins Setup
- Accessed Jenkins at: http://<EC2-PUBLIC-IP>:8080
- Retrieved initial admin password from container
- Installed recommended plugins

---

### 5. Project Creation
- Created a Freestyle project
- Added an Execute Shell build step
- Ran the build successfully

---

### 6. User Management
- Navigated to Manage Jenkins → Manage Users
- Created an additional test user

---

## Result

Jenkins was successfully deployed on AWS EC2 using Docker.
A sample project was created and executed successfully.
Multiple users were configured to demonstrate access management.

