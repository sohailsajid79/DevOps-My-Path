#!/bin/bash

config_parser() {
    local config_file="$1"

    if [ ! -f "$config_file" ]; then
        echo "Configuration file does not exist"
        return 1
    fi

    while IFS='=' read -r key value; do
        # remove empty lines and lines starting with '#'
        if [[ -n "$key" && "$key" != \#* ]]; then
            # trim whitespaces
            key=$(echo "$key" | xargs)
            value=$(echo "$value" | xargs)
            echo "Key: $key, Value: $value"
        fi
    done < "$config_file"

}

config_parser "$1"

### Grant executable permissions
# chmod +x ./12-Solution.sh 

### Test case #1:
# ./12-Solution.sh 12-Level/config.conf
# Key: db_host, Value: localhost
# Key: db_port, Value: 5432
# Key: db_name, Value: my_database
# Key: db_user, Value: admin
# Key: db_password, Value: supersecretpassword
# Key: server_name, Value: my_server
# Key: server_port, Value: 8080
# Key: max_connections, Value: 100
# Key: enable_logging, Value: true
# Key: app_mode, Value: production
# Key: log_file_path, Value: /var/log/app.log
