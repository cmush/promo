#!/bin/bash

echo "PORT=${PORT}"
export PORT=${PORT}

echo "BASE_URL_DIRECTIONS=${BASE_URL_DIRECTIONS}"
export BASE_URL_DIRECTIONS=${BASE_URL_DIRECTIONS}

echo "BASE_URL_DISTANCE_MATRIX=${BASE_URL_DISTANCE_MATRIX}"
export BASE_URL_DISTANCE_MATRIX=${BASE_URL_DISTANCE_MATRIX}

echo "GMAPS_API_KEY=${GMAPS_API_KEY}"
export GMAPS_API_KEY=${GMAPS_API_KEY}

echo "DATABASE_URL=${DATABASE_URL}"
export DATABASE_URL=${DATABASE_URL}

echo "starting promo in foreground mode"
/opt/app/bin/promo foreground

