#docker pull pingcap/tidb:latest
#docker pull pingcap/tikv:latest
#docker pull pingcap/pd:latest
docker run -d --name pd1 \
  -p 2379:2379 \
  -p 2380:2380 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /pd-data1:/data \
  pingcap/pd:latest \
  --name="pd1" \
  --data-dir="/data/pd1" \
  --client-urls="http://0.0.0.0:2379" \
  --advertise-client-urls="http://67.216.207.175:2379" \
  --peer-urls="http://0.0.0.0:2380" \
  --advertise-peer-urls="http://67.216.207.175:2380" \
  --initial-cluster="pd1=http://67.216.207.175:2380,pd2=http://67.216.207.175:2382,pd3=http://67.216.207.175:2384"

docker run -d --name pd2 \
  -p 2381:2381 \
  -p 2382:2382 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /pd-data2:/data \
  pingcap/pd:latest \
  --name="pd2" \
  --data-dir="/data/pd2" \
  --client-urls="http://0.0.0.0:2381" \
  --advertise-client-urls="http://67.216.207.175:2381" \
  --peer-urls="http://0.0.0.0:2382" \
  --advertise-peer-urls="http://67.216.207.175:2382" \
  --initial-cluster="pd1=http://67.216.207.175:2380,pd2=http://67.216.207.175:2382,pd3=http://67.216.207.175:2384"

docker run -d --name pd3 \
  -p 2383:2383 \
  -p 2384:2384 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /pd-data3:/data \
  pingcap/pd:latest \
  --name="pd3" \
  --data-dir="/data/pd3" \
  --client-urls="http://0.0.0.0:2383" \
  --advertise-client-urls="http://67.216.207.175:2383" \
  --peer-urls="http://0.0.0.0:2384" \
  --advertise-peer-urls="http://67.216.207.175:2384" \
  --initial-cluster="pd1=http://67.216.207.175:2380,pd2=http://67.216.207.175:2382,pd3=http://67.216.207.175:2384"

docker run -d --name tikv1 \
  -p 20160:20160 \
  --ulimit nofile=1000000:1000000 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tikv-data1:/data \
  pingcap/tikv:latest \
  --addr="0.0.0.0:20160" \
  --advertise-addr="67.216.207.175:20160" \
  --data-dir="/data/tikv1" \
  --pd="67.216.207.175:2379,67.216.207.175:2381,67.216.207.175:2383"

docker run -d --name tikv2 \
  -p 20161:20161 \
  --ulimit nofile=1000000:1000000 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tikv-data2:/data \
  pingcap/tikv:latest \
  --addr="0.0.0.0:20161" \
  --advertise-addr="67.216.207.175:20161" \
  --data-dir="/data/tikv2" \
  --pd="67.216.207.175:2379,67.216.207.175:2381,67.216.207.175:2383"

docker run -d --name tikv3 \
  -p 20162:20162 \
  --ulimit nofile=1000000:1000000 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tikv-data3:/data \
  pingcap/tikv:latest \
  --addr="0.0.0.0:20162" \
  --advertise-addr="67.216.207.175:20162" \
  --data-dir="/data/tikv3" \
  --pd="67.216.207.175:2379,67.216.207.175:2381,67.216.207.175:2383"


docker run -d --name tidb \
  -p 4000:4000 \
  -p 10080:10080 \
  -v /etc/localtime:/etc/localtime:ro \
  pingcap/tidb:latest \
  --store=tikv \
  --path="67.216.207.175:2379,67.216.207.175:2381,67.216.207.175:2383"

#or
docker start pd1
docker start pd2
docker start pd3
docker start tikv1
docker start tikv2
docker start tikv3
docker start tidb

#test
mysql -h 127.0.0.1 -P 4000 -u root -D test
