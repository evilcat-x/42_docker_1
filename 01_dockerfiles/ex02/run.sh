# pull false as build will default to check latest, we need local images
docker build --pull=false -t ft-rails:on-build ft-rails
docker build --pull=false -t seli_ex02 .
docker run -d \
	--name=seli_ex02 \
	-p 3000:3000 \
	seli_ex02
