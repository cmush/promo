#!/bin/bash

echo "BASE_URL_DIRECTIONS"
export BASE_URL_DIRECTIONS=${BASE_URL_DIRECTIONS}

echo "BASE_URL_DISTANCE_MATRIX"
export BASE_URL_DISTANCE_MATRIX=${BASE_URL_DISTANCE_MATRIX}

echo "GMAPS_API_KEY"
export GMAPS_API_KEY=${GMAPS_API_KEY}

echo "creating and exporting DATABASE_URL"
export DATABASE_URL=${DATABASE_URL}

echo "starting africabeat_umbrella in foreground mode"
/opt/app/bin/promo foreground

