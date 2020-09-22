# embulk-filter-url_decode

## これは

* embulk の filter プラグインサンプルです

## Setup

### Require

* Docker
* docker-compose

### docker build

```sh
$ docker-compose build
$ docker-compose up -d
```

## Development

### Write Plugin

```sh
$ vim plugins/embulk/filter/url_decode.rb
```

### In docker container

Docker コンテナには `docker exec -t -i embulk bash` でログイン, ログイン後に以下を実行します.

```sh
# plugin のインストール
$ embulk bundle

# 動作確認
$ embulk preview config.sample.yml --load-path ./plugins

# 実行
$ embulk run config.sample.yml --load-path ./plugins
```
