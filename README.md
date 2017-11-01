# Docker Task
[![Docker Pulls](https://img.shields.io/docker/pulls/strm/task.svg?style=plastic)](https://hub.docker.com/r/strm/task/)

This is a simple way to run tasks in a certain interval inside a docker container.

# Customizating your task

This image doesn't do anything by itself, you need to extend (`FROM`) this image to make it work as you want. Copy your task, or the script to start your task, to `/task.sh`, that it's done.

# Running your task

Just start your task container as

```
docker run --rm -it \
	-e "INVERTAL=3600" \
	-e "MODE=cron"
	yourimage
```

# Variables

 * `INTERVAL` - The interval, in seconds, between each task execution.
 * `MODE` - The operation mode, `cron` is the only one at the moment, and forever, see [deprecation](/#deprecation notice) notice bellow.

# Deprecation notice

This project is deprecated, move to [tasker](https://github.com/opsxcq/tasker) to have a better task management.

