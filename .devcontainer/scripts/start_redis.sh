#!/usr/bin/env zsh

# Start the redis server
mkdir -p /workspace/tmp/sidekiq-redis
sudo redis-server --dir /workspace/tmp/sidekiq-redis >>/workspace/tmp/redis.log 2>>/workspace/tmp/redis.log &
