FROM swift:4.1

USER root
COPY ./Sources /StockKit/Sources
COPY ./Package.swift ./Package.resolved ./conf.yml /StockKit/

WORKDIR /StockKit
RUN swift build

CMD ["./.build/debug/StockKit", "./conf.yml"]