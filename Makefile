IMAGE_NAME=hello-heroku
PORT=5005

build:
	dotnet build

docker-build:
	docker build --tag=$(IMAGE_NAME) .

docker-run: docker-build
	docker run -e PORT=$(PORT) -p $(PORT):$(PORT) $(IMAGE_NAME):latest

heroku-deploy: heroku-push
	heroku container:release web -a asp-net-core-app-example

heroku-push: docker-build
	heroku container:push web -a asp-net-core-app-example

run:
	dotnet run --project src/HelloHeroku
