#!/bin/ash

eval $(
  aws ssm get-parameters-by-path \
    --recursive \
    --with-decryption \
    --path $ENV_PATH |
  jq -r '.Parameters[] | [.Name, .Value] | @tsv' |
  while read name value; do \
    echo "export $(basename $name)=$value"; \
  done
)

exec "$@"

