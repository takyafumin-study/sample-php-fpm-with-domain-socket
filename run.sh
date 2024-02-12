#!/usr/bin/env bash

if [ ! -f ./.env ]; then
  echo "file not found. [./env]";
  exit 0;
fi
# shellcheck disable=SC1091
source .env

function display_help {
    echo "Usage:";
    echo "  run.sh [command] [options/sub-command]"
    echo "";
    echo "command:";
    echo "  environment:";
    echo "      init                    Create develop environment";
    echo "      up   [options]          Execute docker compose up";
    echo "      down [options]          Execute docker compose down";
    echo "";
    echo "  develop:";
    echo "      app                     Execute shell on App Container";
    echo "      web                     Execute shell on Web Container";
    echo "      artisan [sub-command]   Execute artisan command on App Container";
    echo "      tinker                  Execute php artisan tinekr on App Container";
    echo "";
    echo "  build:";
    echo "      build:prod              Build for Production";
    echo "";
    echo "  others:";
    echo "      help                    Display command help";
    echo "";
    exit 0;
}

# --------------------
#
# 各コマンド
#
# --------------------
if [ $# = 0 ]; then
  display_help

elif [ "$1" = "help" ]; then
  display_help

elif [ "$1" = "init" ]; then
  if [ ! -f ./src/.env ]; then
    cp ./src/.env.example ./src/.env
  fi
  docker compose run app composer install
  docker compose up -d

elif [ "$1" = "up" ]; then
  shift 1
  docker compose up "$@"

elif [ "$1" = "down" ]; then
  shift 1
  docker compose down "$@"

elif [ "$1" = "web" ]; then
  shift 1
  docker compose exec web "${@:-sh}"

elif [ "$1" = "app" ]; then
  shift 1
  docker compose exec app "${@:-sh}"

elif [ "$1" == "artisan" ]; then
  shift 1
  docker compose exec app php artisan "$@"

elif [ "$1" == "tinker" ]; then
  docker compose exec app php artisan tinker

elif [ "$1" = "build:prod" ]; then
  docker compose -f compose.prod.yml build

elif [ $# -ge 1 ]; then
  # 未指定のパラメータの場合、docker-copmoseコマンドをそのまま呼び出す
  docker compose "$@"
fi