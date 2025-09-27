FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files separately for restore
COPY ["ezSCORES.Model/ezSCORES.Model.csproj", "ezSCORES.Model/"]
COPY ["ezSCORES.Subscriber/ezSCORES.Subscriber.csproj", "ezSCORES.Subscriber/"]

# Restore only the Subscriber project
RUN dotnet restore "ezSCORES.Subscriber/ezSCORES.Subscriber.csproj"

# Copy all files
COPY . ./

# Build the Subscriber project
WORKDIR /app/ezSCORES.Subscriber
RUN dotnet build "ezSCORES.Subscriber.csproj" -c Release -o /app/build

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/build ./

ENTRYPOINT ["dotnet", "ezSCORES.Subscriber.dll"]
