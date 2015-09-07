# Idler

[![Gem Version](https://badge.fury.io/rb/idler.svg)](http://badge.fury.io/rb/idler)
[![Circle CI](https://circleci.com/gh/toihrk/idler.svg?style=svg)](https://circleci.com/gh/toihrk/idler)


ブランチ毎に異なるスクリプトを実行するコマンド`idler`を提供します。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install idler

## Usage

### Initialize

	$ bundle exec idler init

カレントディレクトリに`.idler.rb`を配置します。

### Edit `.idler.rb`

```ruby
branch 'master' do
  desc   'master branch description here'
  detail 'master branch detail here'
  worker do
  	# Something script here
  end
end
```

**`branch(branch_name, &block)`**

`branch_name` ブランチ名の文字列を与える

ブロック内では以下のメソッドでブランチ毎の動作を定義する

- **`desc(description)`** ブランチの説明を`description`で与える
- **`detail(note)`**      ブランチの詳細を`note`で与える
- **`worker(&block)`**    ブランチでの動作を定義

### Commands


	$ idler 
	
現在のブランチで定義済みの動作を行う

	$ idler develop

`develop`ブランチで定義済みの動作を行う


	$ idler info
	
定義済みのブランチの情報を表示

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/toihrk/idler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).



