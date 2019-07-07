docker pull wurstmeister/zookeeper
docker pull wurstmeister/kafka
sudo docker run --name zookeeper -p 2181:2181 -v /docker/kafka/zoo_log:/opt/zookeeper-3.4.9/data -t wurstmeister/zookeeper
##create link 'zk' to zookeeper
#sudo docker run --name kafka -e HOST_IP=localhost -e KAFKA_ADVERTISED_PORT=9092 -e KAFKA_BROKER_ID=1 -e ZK=zk -p 9092:9092 --link zookeeper:zk -t wurstmeister/kafka
sudo docker run --name kafka -e HOST_IP=localhost  -e KAFKA_ADVERTISED_HOST_NAME=172.17.0.1 -e KAFKA_ADVERTISED_PORT=9092 -e KAFKA_BROKER_ID=1 -e ZK=zk -p 9092:9092  -e KAFKA_ZOOKEEPER_CONNECT=172.17.0.1:2181 -e KAFKA_HEAP_OPTS="-Xmx256M -Xms64M" --link zookeeper:zk -t wurstmeister/kafka
sudo docker run zookeeper
sudo docker run kafka

##test kafka
docker exec -it kafka /bin/bash   
cd /opt/kafka_2.12-1.0.1/
bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic mykafka
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic mykafka  
bin/kafka-console-consumer.sh --zookeeper zookeeper:2181 --topic mykafka --from-beginning  

