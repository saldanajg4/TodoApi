FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build

ARG BUILDCONFIG=RELEASE
ARG VERSION=1.0.0

COPY TodoApi.csproj /build/

RUN dotnet restore ./build/TodoApi.csproj

COPY . ./build/
WORKDIR /build/
RUN dotnet publish ./TodoApi.csproj -c ${BUILDCONFIG} -o out /p:Version=${VERSION}

FROM mcr.microsoft.com/dotnet/core/aspnet
WORKDIR /app

COPY --from=build /build/out .

ENTRYPOINT ["dotnet", "TodoApi.dll"]
