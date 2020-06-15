sudo docker run -d \
  --restart always \
  --entrypoint /usr/local/bin/keep-ecdsa \
  --volume $HOME/keep-ecdsa:/mnt/keep-ecdsa \
  --env KEEP_ETHEREUM_PASSWORD=$KEEP_CLIENT_ETHEREUM_PASSWORD \
  --env LOG_LEVEL=debug \
  --name ecdsa \
  -p 3920:3919 \
  keepnetwork/keep-ecdsa-client:v1.0.0 \
  --config /mnt/keep-ecdsa/config/config.toml start