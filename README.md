# Spark2.2.1 in Docker with python3.5.3

### docker build
> docker build -t skybearlove/spark2.2.1-python3.5.3 .
### docker run
> docker run -it --rm -v ~/Code/kkbox/kkbox_data:/root/ -p 4040:4040 -p 8080:8080 -p 8081:8081 -h spark --name=spark skybearlove/spark2.2.1-python3.5.3
