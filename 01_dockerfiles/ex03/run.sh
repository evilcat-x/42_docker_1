docker build -t seli_ex03 .
docker run -it \
	--rm \
	--name seli_ex03 \
	-p 443:443 \
	-p 80 \
	-p 22 \
	seli_ex03
