docker exec -it $(docker ps |grep 'tms_dev_env_php-cli'|awk 'NR = 1 {print $1}') bash
