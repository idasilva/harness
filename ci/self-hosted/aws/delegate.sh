docker run -d --network host \
  -e DELEGATE_NAME=docker-delegate \
  -e NEXT_GEN="true" \
  -e DELEGATE_TYPE="DOCKER" \
  -e ACCOUNT_ID=9leDao-yRqu7DN66CVDAeg \
  -e DELEGATE_TOKEN=NGVmYzQ5MjhjYzVhY2ZlODlkNzcyNzhkM2ZhZTFhMWI= \
  -e DELEGATE_TAGS="" \
  -e MANAGER_HOST_AND_PORT=https://app.harness.io us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.12.87402


docker run -v /runner:/runner -p 3000:3000 drone/drone-runner-aws:latest  delegate --pool /runner/pool.yml
