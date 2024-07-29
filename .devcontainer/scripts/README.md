# order of scripts


start_mysql.sh
  launch_db.sh
start_redis.sh
setup_db.sh



# what they do
.zshrc
  - main configuration file for the Zsh (Z shell) shell.
  - called by post_create.sh
.p10k.zsh
  - Configuration file for the Powerlevel10k theme used in Zsh (Z shell)
  - called by post_create.sh
.irbrc
  - Configuration file for Interactive Ruby (IRB), which is a REPL environment for Ruby.
build.sh

docker-entrypoint.sh
  - start mysql `sudo -E launch_db.sh mysqld`
  - start redis server (start_redis.sh)
    - make sidekiq-redis directory
  - run setup_formatif_db.sk, which waits for mysql to start then populates db
launch_db.sh
  - This bash script is an entrypoint for initializing and configuring a MariaDB/MySQL database within a Docker container.
post_create.sh
  - runs .szhrc
  - runs .p10k.zsh
  - runs .irbrc
  - *
  - sudo chown vscode:vscode /var/lib/mysql
  - sudo chmod a+rw /workspace/tmp
  - sudo chmod a+rw /workspace/node_modules
  - sudo chown vscode:vscode /student-work
  - sudo chmod a+rw /workspace/doubtfire-web/node_modules
  - sudo chmod a+rw /home/vscode/.gems
  - * start services
  - /workspace/.devcontainer/docker-entrypoint.sh echo "Done"
post_start.sh
  - echo 'Setting up git safe directories'
  - git config --global --add safe.directory /workspace/doubtfire-api
  - git config --global --add safe.directory /workspace/doubtfire-web
  - git config --global --add safe.directory /workspace
  - git config --global submodule.recurse false
  - * check if mysqld and redis-server is running
  - * if one isnt running, re-run post_create.sh
<!-- publish.sh -->
setup_formatif_db.sh
  - The script waits for MySQL (mysqld) to start, checks its readiness, creates and populates the database if necessary, and runs a background simulation task.
  - *
  - checks for mysql locally, will need to find another way to check mysql process
    - db-api can attempt mysql connection to the mysql service

  - `cd /workspace/doubtfire-api`
  - `bundle install` -- installs ruby api dependencies
  - populate/seed database
  - simulate signoff (assess tasks, add task comments etc)



# considerations
- a bash script that runs externally from the container, `docker exec`'ing into each container and running required scripts?


```bash
  #!/bin/bash

  # Function to execute a command in a container and wait for it to complete
  exec_in_container() {
    local container="$1"
    local cmd="$2"

    docker exec "$container" bash -c "$cmd"
  }

  # Define the order of operations
  exec_in_container "container1" "/path/to/script1.sh"
  exec_in_container "container2" "/path/to/script2.sh"
  exec_in_container "container3" "/path/to/script3.sh"

  echo "All scripts executed in order."
```
