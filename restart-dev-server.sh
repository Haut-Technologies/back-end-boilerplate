rm -rf emails; sh compile-for-dev-server.sh && \
    mkdir emails && \
    sudo docker-compose up -d --build server \
    && sudo docker image prune -f && cd db_client && \
    DATABASE_URL='postgres://postgres:mysecretpassword@localhost:5431/postgres' diesel migration redo \
    ; cd ..
