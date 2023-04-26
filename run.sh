# build jupyterlab image
docker build -t jupyterlab .

# run docker compose file run and build a spark standalone cluster
docker-compose up --detach

