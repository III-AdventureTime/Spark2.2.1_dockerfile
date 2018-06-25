FROM openjdk:8

MAINTAINER IanLin

# Scala Download URL.
ARG scalaVersion=2.12.2
ARG scalaURL=http://downloads.lightbend.com/scala/${scalaVersion}/scala-${scalaVersion}.tgz

# Spark Download URL.
ARG sparkVersion=2.2.1
ARG sparkURL=http://apache.stu.edu.tw/spark/spark-${sparkVersion}/spark-${sparkVersion}-bin-hadoop2.7.tgz 

# Setting env variables for scala and spark.
ENV SCALA_HOME  /usr/local/scala
ENV SPARK_HOME  /usr/local/spark
ENV PATH        $SCALA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

# Update apt-get and install nano ipython3 python3 and clian all catch.
RUN apt-get -y -q update \
 && apt-get install -y vim nano python3 ipython3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* \
 && wget -qO - ${scalaURL} | tar -xz -C /usr/local/ \
 && wget -qO - ${sparkURL} | tar -xz -C /usr/local/ \
 && cd /usr/local/ \
 && ln -s scala-${scalaVersion} scala \
 && ln -s spark-${sparkVersion}-bin-hadoop2.7 spark

RUN touch /root/.bashrc \
 && echo "export PYSPARK_PYTHON=python3"  >> /root/.bashrc \
 && echo "export PYSPARK_DRIVER_PYTHON=ipython3" >> /root/.bashrc \
 && echo 'alias ll="ls -alh"' >> /root/.bashrc \
 && mkdir /root/data
 
 # Setup the python version of pyspark

# Logging as root.
USER root

# Working diretory is at /root
WORKDIR /root/data

# Expose Spark port.
# SparkContext web UI on 4040, Spark master’s web UI on 8080, Spark worker web UI on 8081.
#EXPOSE 4040 8080 8081

CMD ["/bin/bash"]
