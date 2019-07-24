#!/usr/bin/env bash

psql -c 'create database promo_test;' -U postgres
mix ecto.migrate