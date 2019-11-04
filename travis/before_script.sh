#!/usr/bin/env bash

psql -c 'create database promo_test;' -U postgres
psql -c "CREATE USER postgres WITH PASSWORD 'postgres';" -U postgres
MIX_ENV=test mix ecto.migrate