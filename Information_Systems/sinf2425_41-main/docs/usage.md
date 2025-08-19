# Usage

## 0. Preparation

1. Begin by reviewing the `docker/docker-compose.yml` file to familiarize yourself with the software components involved. **Please do not make any changes to this file!**

2. The `docker/.env` file contains the default user and password pairs used for various services within the development environment (including database passwords, ports, etc.). **The only information you need to modify is the following:**
    ```bash
      ...
      UID=yyy  (to get yyy use the cmd - $id -u)
      GID=xxx  (to get xxx use the cmd - $id -g)
    ```

    These instructions demand Docker to save Grafana's data with your local user and group. **Please do not change any other configuration settings!**

## 1. Start the Services

Use the following commands from the root of your project.
```bash
# Build and start all services
docker compose -f docker/docker-compose.yml up -d

# View running containers
docker ps -a

# View logs of a container
docker logs <container_name>

# Open a terminal within a container
docker exec -it <container_name> bash
```

## 2. Access Services

- **PostgreSQL**: `localhost:5432`
- **Dinasore**: `localhost:4840 (OPC Port)` and `localhost:61499 (4DIAC-IDE)`
- **PgAdmin4**: `http://localhost:8080`
  - Default login credentials will be in your `docker/.env`
- **Grafana**: `http://localhost:8081`
  - Default login credentials will be in your `docker/.env`

## 3. Stopping the Services

```bash
# Stop and remove containers
docker compose -f docker/docker-compose.yml down

# Stop and remove containers and volumes.
# Running this will make you loose all the persistent data previously stored!
docker compose -f docker/docker-compose.yml down -v --remove-orphans
```

## 4. Using 4DIAC-IDE

4DIAC-IDE can be found in the `4diac-ide` subdirectory. To start the application, run the executable located in that subdirectory (e.g. `$ ./4diac-ide/4diac-ide`).

## 5. Persistent Storage

> This is important to synchronize developments within your team.

**Grafana data** will be stored in `docker/data/grafana`.

**However, you will need to manually back up your PostgreSQL data.** To save your database data, execute the following command from the project's root directory:
```bash
docker exec -t postgres pg_dump -c -U sinf sinf > docker/data/postgres/dump.sql
```
This will generate an .sql file located in `docker/data/postgres`. **You can then push the dump file to your remote repository to share it** with your colleagues.

This backup will be particularly useful in the event that you delete all your data. If you need to restore PostgreSQL to its previous state, start the container and run the following command:
```bash
cat docker/data/postgres/dump.sql | docker exec -i postgres psql -U sinf
```

**Please ensure that the contents of `docker/data/grafana` and `docker/data/postgres` are stored securely; otherwise, you risk losing all your developments.**