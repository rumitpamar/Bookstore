# #!/bin/bash

# # PostgreSQL connection details
# PG_HOST="postgres.cfw7rb0ojnm7.us-east-1.rds.amazonaws.com"
# PG_PORT="5432"
# PG_USER="admin123"
# PG_PASSWORD="tXoVkMxKBsbPO9mP"
# PG_DATABASE="postgres"

# # Check PostgreSQL connectivity
# PG_COMMAND="psql -h '$PG_HOST' -p '$PG_PORT' -U '$PG_USER' -d '$PG_DATABASE' -c 'SELECT 1;'"
# PG_OUTPUT=$(PGPASSWORD="${PG_PASSWORD}" eval "$PG_COMMAND" 2>&1)

# # Check the output for successful connection
# if [ $? -eq 0 ]; then
#   echo "PostgreSQL database connection successful"
#   exit 0  # Success exit code
# else
#   echo "Failed to connect to PostgreSQL database: $PG_OUTPUT"
#   exit 1  # Error exit code
# fi



# #!/bin/bash

# PG_HOST="postgres.cfw7rb0ojnm7.us-east-1.rds.amazonaws.com"
# PG_PORT="5432"
# PG_USER="admin123"
# PG_PASSWORD="tXoVkMxKBsbPO9mP"
# PG_DATABASE="postgres"

    
# if PGPASSWORD=$PG_PASSWORD psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DATABASE -c "\q"; then
#     echo "PostgreSQL connection successful. Initiating shutdown sequence..."

# else
#     echo "Failed to connect to PostgreSQL."
    
# fi
