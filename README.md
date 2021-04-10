# shopify-multipass-api-on-rails

Shopify Multipass APIでSSOを行うためのサンプルコード。

参照: [Ruby on Rails × Shopify Multipass APIでSSOを試してみる](https://qiita.com/kazama1209/items/7e16b2701cf9e27b1ca9)

## セットアップ

```
$ cp .env.sample .env
```
```
SHOPIFY_MULTIPASS_SECRET=マルチパスのシークレットキー
SHOPIFY_STORE_DOMAIN=Shopifyストアのドメイン
```

「.env」内にそれぞれの値をセット。

```
$ docker-compose build
$ docker-compose run web bundle exec rails webpacker:install
$ docker-compose run web bundle exec rails db:create
$ docker-compose run web bundle exec rails db:migrate
$ docker-compose up -d
```

コンテナを起動。
