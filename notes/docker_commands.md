sudo docker run -td \
  --name kalipoli \
  --net=host \
  --cap-add=NET_RAW \
  --cap-add=NET_ADMIN \
  kalilinux /bin/bash


-ti for interactive
-td for running indefinitely





