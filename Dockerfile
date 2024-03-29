FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["DevOps_Demo.csproj", ""]
RUN dotnet restore "DevOps_Demo.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "DevOps_Demo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DevOps_Demo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DevOps_Demo.dll"]