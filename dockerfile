# =========================
# Build Stage
# =========================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

# Copy project file และ restore ก่อน
COPY *.csproj ./
RUN dotnet restore

# Copy source code
COPY . ./

# Publish
RUN dotnet publish -c Release -o /app/publish --no-restore


# =========================
# Runtime Stage
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final

WORKDIR /app

COPY --from=build /app/publish .

# Blazor Server / ASP.NET Core
ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

ENTRYPOINT ["dotnet", "MyBlazorApp.dll"]