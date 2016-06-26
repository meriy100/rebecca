## セットアップ

```
cp config/database.yml.default config/database.yml
```

- ライブラリのインストール

```sh
bundle install --path vendor/bundle
```
- DB作成

```sh
bundle exec rake db:create
```

- DBマイグレート
```sh
bundle exec rake db:migrate:reset # DBの構成が固まるまではこれで
```

- localhost:3000
```sh
bundle exec rails s
```

## コミットの前に

```
rubocop
rails_best_practices
```
