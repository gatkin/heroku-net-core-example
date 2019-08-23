FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./src ./src
COPY *.sln ./

RUN dotnet restore

# Copy everything else and build
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app

# Run as a non-root user
RUN groupadd -r app && \
    useradd -r -g app -d /home/app -s /sbin/nologin -c "Docker image user" app
RUN chown -R app:app /app
USER app

COPY --from=build-env /app/src/HelloHeroku/out .

# Listen on the port provided by the docker container runtime
CMD dotnet HelloHeroku.dll --urls=http://*:$PORT