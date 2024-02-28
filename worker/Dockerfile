FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:7.0
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM
RUN echo "TARGETPLATFORM: $TARGETPLATFORM" && \ 
    echo "TARGETARCH: $TARGETARCH" && \ 
    echo "BUILDPLATFORM: $BUILDPLATFORM"
WORKDIR /source
COPY . .
RUN dotnet restore -a $TARGETARCH && dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore
CMD ["dotnet", "/app/Worker.dll"]