FROM rust:1.65
RUN apt install -y curl
RUN curl -L -o cargo-watch.deb https://github.com/watchexec/cargo-watch/releases/download/v8.1.2/cargo-watch-v8.1.2-x86_64-unknown-linux-gnu.deb
RUN apt install ./cargo-watch.deb
