FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 5000

ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["WeatherInfoAPI.csproj", "./"]
RUN dotnet restore "WeatherInfoAPI.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "WeatherInfoAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WeatherInfoAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WeatherInfoAPI.dll"]
