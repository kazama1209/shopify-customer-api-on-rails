# shopify-customer-api-on-rails

Shopify Customer APIで顧客情報の操作を行うためのサンプルコード。

参照: [Ruby on Rails × Shopify Customer API で顧客情報を操作してみる](https://qiita.com/kazama1209/items/fea6de9dceb20203eddb)

## セットアップ

```
$ cp .env.sample .env
```
```
SHOPIFY_MULTIPASS_SECRET=マルチパスのシークレットキー
SHOPIFY_STORE_DOMAIN=Shopifyストアのドメイン
SHOPIFY_API_KEY=ShopifyプライベートアプリのAPIキー
SHOPIFY_PASSWORD=Shopifyプライベートアプリのパスワード
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
