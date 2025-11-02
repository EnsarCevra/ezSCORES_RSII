FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ezSCORES.Model/ ezSCORES.Model/
COPY ezSCORES.Subscriber/ ezSCORES.Subscriber/

WORKDIR /src/ezSCORES.Subscriber

RUN dotnet restore
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "ezSCORES.Subscriber.dll"]