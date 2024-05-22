Create a relevant dev-config/prod-config file in configs.
Build the docker images using

For dev
`docker build -t dashboard --build-arg env="dev" .`

For prod
`docker build -t dashboard --build-arg env="prod" .`
