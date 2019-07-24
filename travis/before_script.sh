#!/usr/bin/env bash

psql -c 'create database promo_test;' -U postgres
MIX_ENV=test mix ecto.migrate