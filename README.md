## Quick start for development:

- Install the rust toolchain by following [these instructions](https://rustup.rs/)
- Install VSCode plugin `maklad:rustanalyzer`
- Install docker and docker-compose
  - For Debian based Linux distributions (includes Ubuntu):
    - `sudo apt install docker.io`
    - `sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
    - `sudo chmod +x /usr/local/bin/docker-compose`
  - For MacOS:
    - `brew install --cask docker`
  - For Windows: Please use [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) or run a virtual machine running Linux and follow instructions for Linux
- Install `diesel` CLI with the PostgreSQL feature - requires libpq client library to be installed, installation depends on OS distribution
    - Ubuntu: https://howtoinstall.co/en/libpq-dev
    - MacOS: https://formulae.brew.sh/formula/postgresql and https://formulae.brew.sh/formula/libpq 
```sh
cargo install diesel_cli --no-default-features --features postgres
```
and then run the following commands:

```sh
# generates static binary for server ./server
sh compile-for-dev-server.sh
# builds database image and server images using the latest binary
# and runs the database and server as containers where requests
# can be made to the server on port 3030
sudo docker-compose up --build
```
> If you running Apple Silicon, you may have problems running `sh compile-for-dev-server.sh`. If that is the case, then remove `server` from the list of `services` in `docker-compose.yml`, move `environment` values into a `.env` file and replace `db:5432` with `localhost:5431` as the network address within the `DATABASE_URL` environment variable. Then you can run
```sh
sh dockerfile-gen.sh
docker compose up --build
RUSTFLAGS='-L /opt/homebrew/opt/libpq/lib' cargo run
```

After making changes the following command can be run to rebuild the
server:

```sh
sh restart-dev-server.sh
```
> If you using an M1 processor, run `RUSTFLAGS='-L /opt/homebrew/opt/libpq/lib' cargo run` instead

## Database migrations
e.g.
```sh
cd db_client
diesel migration generate migration_name
cd ..
sh restart-dev-server.sh
```
This will generate update `db_client/src/schema/mod.rs`
so you can then start writing Rust code against the new schema 
