# deploy
Deploy data science models with a single command using docker

## Installation
```bash
git clone https://github.com/mconley-kaizen/deploy.git
cd deploy
source launch.sh
```

## Usage
```bash
deploy <port> <model package name> <model package entrypoint> <docker image name>
```

```bash
deploy 5000 iris_prediction main mydockerap
```
