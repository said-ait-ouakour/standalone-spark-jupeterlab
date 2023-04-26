# define base image 
ARG debian_image_tag=8-jre-slim
FROM openjdk:${debian_image_tag}

# define spark version
# define jupyter lab version
# Note: We are using version 3.3.0 Big Data Europe spark-hadoop image
ARG spark_version=3.3.0
ARG jupyterlab_version=2.1.5


# install python and pyspark && jupyterlab
RUN apt-get update -y && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    pip3 install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version}

# -- Runtime
# expose the jupyterlab port 
EXPOSE 8888

# define the working directory
WORKDIR /opt/workspace/

# default command on the launch of this image instances 
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=