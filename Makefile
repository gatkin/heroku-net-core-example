IMAGE_NAME=hello-heroku
PORT=5005

build:
	dotnet build

docker-build:
	docker build --tag=$(IMAGE_NAME) .

docker-run: docker-build
	docker run -p $(PORT):80 $(IMAGE_NAME):latest

run:
	dotnet run --project src/HelloHeroku
