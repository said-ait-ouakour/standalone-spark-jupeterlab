# define base image 
ARG python_image_tag=3.7.10
FROM python:${python_image_tag}

# define spark version
# define jupyter lab version
# Note: We are using version 3.3.0 Big Data Europe spark-hadoop image
ARG spark_version=3.3.0
ARG jupyterlab_version=2.1.5


# install python and pyspark && jupyterlab
RUN pip install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version}


RUN apt update && apt upgrade && \
    apt install default-jre 


RUN echo "JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64'" >> /etc/environment

# -- Runtime
# expose the jupyterlab port 
EXPOSE 8888

# define the working directory
WORKDIR /opt/workspace/

# default command on the launch of this image instances 
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=