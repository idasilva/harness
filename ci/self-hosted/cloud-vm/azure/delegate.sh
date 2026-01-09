docker run -d --network host \
  -e DELEGATE_NAME=docker-delegate-azure \
  -e NEXT_GEN="true" \
  -e DELEGATE_TYPE="DOCKER" \
  -e ACCOUNT_ID=XPTO \
  -e DELEGATE_TOKEN=XPTO= \
  -e DELEGATE_TAGS="" \
  -e MANAGER_HOST_AND_PORT=https://app.harness.io us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.12.87402

docker run -v /runner:/runner -p 3000:3000 drone/drone-runner-aws:1.0.0-rc.233 delegate --pool /runner/pool.yml
or docker run -v /runner:/runner -p 3000:3000 drone/drone-runner-aws:latest delegate --pool /runner/pool.yml


custom image:
    docker run -v /runner:/runner -p 3000:3000 idasilva6/drone-runner-aws:v1.0.0 delegate --pool /runner/pool.yml
