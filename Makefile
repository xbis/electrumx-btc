
# Run server
run: 
	docker run -v /opt/electrumx-btc:/data -e DAEMON_URL=http://admin1:123@172.17.0.1:19001/ -p 19502:19502 attic:electrumx-btc


# Build Docker image
docker_build: 
	docker build -t attic:electrumx-btc .


