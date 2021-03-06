source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# テンプレートエンジン
gem "slim"
# ハッシュモデル
gem "active_hash"
# モデルにカラムコメント
# gem 'annotator'
# 論理削除
gem 'acts_as_paranoid', github: 'ActsAsParanoid/acts_as_paranoid'

gem "bootstrap_form"
gem "ransack"

# カレンダー選択用
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'

gem 'bootstrap-slider-rails'

gem 'uuidtools'

# turbolinks progress bar
gem 'nprogress-rails'

# コード解析
gem "rubocop"
gem "rails_best_practices"

gem "google-api-client"
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors'          # エラー画面を見やすくする
  gem 'binding_of_caller'      # better_errorsのエラー画面でREPLが使える
  gem 'tapp'                   # プリントデバッグがしやすくなる
  gem 'pry-rails'              # railsでpryが使える
  gem 'pry-byebug'             # pryでデバックコマンドが使える
  gem 'awesome_print'          # プリントデバッグの出力を整形
  gem 'hirb'                   # SQLの結果を見やすく整形してくれる
  gem 'hirb-unicode'           # hirbの日本語対応
  gem 'bcrypt-ruby'
  gem 'rails_best_practices'
  gem 'spring'

  # テスト関連
  gem "rspec"
  gem 'rspec-rails'
  gem 'rspec-request_describer'
  gem "json_spec"
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'timecop'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
