set -e

sudo rm -rf gitlab-runner
mkdir -p gitlab-runner/config
mkdir -p gitlab-runner/config/certs
touch gitlab-runner/config/config.toml

if [ ! -d $HOME/.step ]
then
 cd ../ca
 ./gen_certs.sh install
 cd ../gitlab2/
fi

cp -r $HOME/.step/certs/root_ca.crt gitlab-runner/config/certs/ca.crt

if command -v docker-compose 2>&1 >/dev/null
then
 docker-compose up -d
elif command -v docker 2>&1 >/dev/null
then
 docker compose up -d
else
 echo "Docker not installed! Aborting..."
fi

set +e
