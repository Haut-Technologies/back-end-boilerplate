# speeds up docker build start up
rm -rf bin
# generates dev-*.Dockerfile files from Dockerfile
sh dockerfile-gen.sh
# builds a docker image to statically compile the server
# doesn't use the docker cache to make sure the latest build context from the
# host is used
sudo docker build --no-cache -t clear-dev-builder -f dev-builder.Dockerfile .
if sudo docker run \
  -v $HOME/.cargo/git:/opt/rust/cargo/git \
  -v $HOME/.cargo/registry:/opt/rust/cargo/registry \
  -v $PWD/docker-target:/usr/src/target \
  clear-dev-builder; then
mkdir bin;
cp docker-target/x86_64-unknown-linux-musl/debug/server ./bin
else
  echo "failed to build server binary"
  exit 1;
fi
