# docker-task

How to run to test

```
docker run --rm -it -e "INVERTAL=3600" -e "MODE=cron" -v "$(pwd)/git-conf:/run/secrets/gitconfig" -v "$(pwd)/git-key:/run/secrets/id_rsa" strm/task-ipblacklist
```