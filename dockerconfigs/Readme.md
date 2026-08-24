




modify the command according to your need and the distro if required



docker run -d \
  --name bubuntu \
  --platform linux/amd64 \
  --network host \
  --cap-add NET_RAW \
  --cap-add NET_ADMIN \
  -v ~/shared:/root/host_home \
  bubuntu




docker build --platform linux/amd64 -t bubuntu64 .
