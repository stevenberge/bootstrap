sudo apt-get install docker
sudo service docker start
sudo chmod 777 /var/run/docker.sock
sh kafka_docker.sh
sh tikv_docker.sh
