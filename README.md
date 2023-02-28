## Quick start for development:

- Install the rust toolchain by following [these instructions](https://rustup.rs/)
- Install VSCode plugin `maklad:rustanalyzer`
- Install docker and docker-compose
  - For Debian based Linux distributions (includes Ubuntu):
    - `sudo apt install docker.io`
    - `sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
    - `sudo chmod +x /usr/local/bin/docker-compose`
    - To run `docker` and `docker-compose` without needing `sudo`: `sudo groupadd docker && sudo usermod -aG docker $USER`. Then logout and login back in again to your computer.
  - For MacOS:
    - `brew install --cask docker`
  - For Windows: [Install Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)

and then run the following commands:

```sh
# builds database image and rust development images
# and runs the database and server as containers where requests
# can be made to the server on port 3030
docker-compose up
```

The server will recompile on any source file changes.

## Database migrations

Write timestamped sql files e.g.`20221214151701_example.sql` and then move them into the `cargo_workspace/migrations` directory. The server will reload and apply these migrations.
