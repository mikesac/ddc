build:
	docker build -t dtr.facilitylive.int/infrastructure/proxy:latest .

push:
	docker push dtr.facilitylive.int/infrastructure/proxy:latest
