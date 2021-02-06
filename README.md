aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 311974803617.dkr.ecr.us-west-2.amazonaws.com

docker build -f Dockerfile.builder -t demo-app-builder .

docker tag demo-app-builder:latest 311974803617.dkr.ecr.us-west-2.amazonaws.com/demo-app-builder:$(git rev-parse HEAD)

docker push 311974803617.dkr.ecr.us-west-2.amazonaws.com/demo-app-builder:$(git rev-parse HEAD)

