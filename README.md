# sample-php-fpm-with-domain-socket

php-fpmをUNIXドメインソケットで通信するdockerサンプル

## 使い方

### 環境構築

git cloneした後、以下のコマンドで環境構築する

```bash
./run.sh init
```

## 環境

### dockerコンテナ

| コンテナ名 |  説明   |
| ---------- | ------- |
| app        | nginx   |
| web        | php-fpm |

### 機能

|    機能     |        URL        |
| ----------- | ----------------- |
| Laravel App | http://localhost/ |