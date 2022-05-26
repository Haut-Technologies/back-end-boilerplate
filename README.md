## Quick start for development:

- Install the rust toolchain by following [these instructions](https://rustup.rs/)
- Install VSCode plugin `maklad:rustanalyzer`
- Install docker
    - Debian-based Linux distributions: `sudo apt install docker.io`
- Install `docker-compose` if running Linux
```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
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

After making changes the following command can be run to rebuild the
server:

```sh
sh restart-dev-server.sh
```

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
