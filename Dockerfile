# this version uses rustc version 1.59
FROM ekidd/rust-musl-builder@sha256:8960fdae6f2342acd9c40a2b09358a3fdea8b04175814f358cb00739e71fa570 as builder
USER root

# Build the server
RUN USER=root mkdir clear
WORKDIR /usr/src/clear
COPY Cargo.toml Cargo.lock ./
COPY server ./server
COPY db_client ./db_client
RUN env CARGO_HOME=/opt/rust/cargo env CARGO_TARGET_DIR=/usr/src/target \
    cargo build --release && \
    cp /usr/src/target/x86_64-unknown-linux-musl/release/server /usr/src/server && \
    rm -rf /usr/src/target

# Run server in empty container
FROM alpine:latest
COPY --from=builder /usr/src/server .
USER 1000
CMD ["./server"]
