sudo docker run -d \
  --restart always \
  --entrypoint /usr/local/bin/keep-client \
  --volume $HOME/keep-client:/mnt/keep-client \
  --env KEEP_ETHEREUM_PASSWORD=$KEEP_CLIENT_ETHEREUM_PASSWORD \
  --env LOG_LEVEL=debug \
  --name keep-client \
  -p 3920:3919 \
  keepnetwork/keep-client:v1.2.4-rc \
  --config /mnt/keep-client/config/config.toml start