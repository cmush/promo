#!/bin/bash

echo "creating and exporting DATABASE_URL"
export DATABASE_URL=postgres://${DATABASE_USERNAME}:${DATABASE_PASSWORD}@${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_NAME}

echo "starting africabeat_umbrella in foreground mode"
/opt/app/bin/promo foreground

