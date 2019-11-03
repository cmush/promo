# This is a sample Dockerfile for packaging an Elixir Phoenix application
# as a Docker image. It builds a Distillery release and installs it on
# Alpine Linux. The final image launches the application on the ports specified per app. It
# requires the project ID to be passed in the project_id build arg.
#
# This Dockerfile includes two stages and requires Docker 17.05 or later.
#
# To adapt this Dockerfile to your app, you may need to customize the app_name
# and phoenix_admin_subdir build arguments, as outlined below.


################################################################################
# BUILD STAGE
#
# Builds the umbrella app, does a webpack build to build the assets, and creates a
# release. This stage uses the official Alpine Linux - Elixir base image, and
# installs a few additional build tools such as Node.js.
ARG ALPINE_VERSION=1.9.1
FROM elixir:${ALPINE_VERSION}-alpine AS builder

##############################################################################
## Build arguments. Modify these to adapt this Dockerfile to your app.      ##
## Alternatively, you may specify --build-arg when running `docker build`.  ##

## The name of your Phoenix application.                                    ##
ARG app_name=promo

## The subdirectories of the Phoenix application (`umbrella_application`).  ##
ARG phoenix_admin_subdir=apps/admin
ARG phoenix_africabeat_subdir=apps/africabeat

## The build environment. This is usually prod, but you might change it if  ##
## you have staging environments.                                           ##
ARG build_env=prod

## End build arguments.                                                     ##
##############################################################################


# Set up build environment.
ENV MIX_ENV=${build_env} \
    TERM=xterm

# Set the build directory.
WORKDIR /opt/app

## Install build tools needed in addition to Elixir:
## NodeJS is used for Webpack builds of Phoenix assets.
## Hex and Rebar are needed to get and build dependencies.
## if there are webpack assets to build, install `nodejs nodejs-npm` as well
RUN apk update \
    && apk --no-cache --update add git \
    && mix local.rebar --force \
    && mix local.hex --force

# Copy the application files into /opt/app.
COPY . .

# Build the application.
RUN mix do deps.get, compile

## Build assets by running a Webpack build and Phoenix digest.
#RUN cd assets \
#    && npm install \
#    && ./node_modules/webpack/bin/webpack.js --mode production \
#    && cd -
#
#RUN mix phx.digest

ARG app_vsn=0.1.0
# Create the release & move it to /opt/release.
RUN mix distillery.release ${app_name} --verbose \
    && mv _build/${build_env}/rel/${app_name} /opt/release

# Create the release, and move the artifacts to /opt/release.
RUN mkdir -p /opt/built \
    && mix distillery.release ${app_name} --verbose \
    && cp _build/${build_env}/rel/${app_name}/releases/${app_vsn}/${app_name}.tar.gz /opt/built \
    && cd /opt/built && tar -xzf ${app_name}.tar.gz \
    && rm ${app_name}.tar.gz

################################################################################
# RUNTIME STAGE
#
# Creates the actual runtime image. This is based on a the Alpine Linux base
# image, with only the minimum dependencies for running ERTS.
FROM alpine:3.10.2

# Install dependencies. Bash and OpenSSL are required for ERTS.
RUN apk update && apk --no-cache --update add bash openssl-dev

# The runtime environment for promo
ARG APP_NAME=promo
ARG DATABASE_USERNAME
ARG DATABASE_PASSWORD
ARG DATABASE_NAME
ARG DATABASE_HOST
ARG DATABASE_POOL_SIZE

# Set up build environment.
ENV MIX_ENV=${build_env} \
    TERM=xterm \
    REPLACE_OS_VARS=true \
    DATABASE_USERNAME=${DATABASE_USERNAME} \
    DATABASE_PASSWORD=${DATABASE_PASSWORD} \
    DATABASE_NAME=${DATABASE_NAME} \
    DATABASE_HOST=${DATABASE_HOST} \
    DATABASE_PORT=${DATABASE_PORT} \
    DATABASE_POOL_SIZE=${DATABASE_POOL_SIZE}

# Set the install directory. The app will run from here.
WORKDIR /opt/app

# Obtain the built application release from the build stage.
COPY --from=builder /opt/built .

COPY ./start.sh .
RUN ["chmod", "+x", "start.sh"]
ENTRYPOINT ["./start.sh"]