# Standalone Spark Cluster Docker

This repository contains an implementation of standalone spark cluster on docker and jupeterlab using Big Data Europe images

#### Prerequisites :

* [ ] Docker Installed ( wsl2 & docker For windows )

#### Using Docker Compose :

1. Clone the repository: `git clone https://github.com/sid41x4/standalone-spark-jupeterlab.`

   - For Linux Users : run `run.sh` script
   - For Windows User
     * Build jupeterlab image : docker build -t jupyterlab .
     * Run docker compose : docker-compose up --detach
2. Open a web browser and navigate to

   1. jupyterlab : `http://localhost:8888`
   2. spark-master UI: `http://localhost:8080`
   3. spark-worker UI: `http://localhost`

```yml
  
    version: '3'

    volumes:

    shared-workspace:

        name: "hadoop-distributed-file-system"

        driver: local

    services:

    jupyterlab:

        image: jupyterlab

        container_name: jupyterlab

        ports:

        - 8888:8888

        volumes:

        - shared-workspace:/opt/workspace

        working_dir: /opt/workspace

    spark-master:

        image: bde2020/spark-master:3.3.0-hadoop3.3

        container_name: spark-master

        ports:

        - "8080:8080"

        - "7077:7077"

        volumes:

        - shared-workspace:/opt/workspace

    spark-worker-1:

        image: bde2020/spark-worker:3.3.0-hadoop3.3

        container_name: spark-worker-1

        depends_on:

        - spark-master

        ports:

        - "8081:8081"

        environment:

        - "SPARK_MASTER=spark://spark-master:7077"

        volumes:

        - shared-workspace:/opt/workspace

    spark-history-server:

        image: bde2020/spark-history-server:3.3.0-hadoop3.3

        container_name: spark-history-server

        depends_on:

        - spark-master

        ports:

        - "18081:18081"

        volumes:

        - /tmp/spark-events-local:/tmp/spark-events

        - shared-workspace:/opt/workspace
```

### Get Started :

- Build Image

```bash
docker-compose build
```

* Run Container

```bash
docker-compose up
```
