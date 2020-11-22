# SecureApi

![Test](https://github.com/davidmetta/secure_api/workflows/Test/badge.svg)

SecureApi is a Tiny JWT-based Authenticaton framework for RoR API's

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'secure_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install secure_api

## Usage

### Initializer and Migration

Before using the gem you must run the SecureApi generator:

    $ rails g secure_api:install

This will create an initializer at `config/initializers/secure_api.rb` and a migration at `db/migrate/secure_api_migration.rb`.

Don't forget to migrate your db before continuing, in order to create the `secure_api_tokens` table, you will also need to update the initializer's required fields.

### Usage requirements

In order for the gem to work, your `User` class must have `email` and `password` fields, you can customize them in the initializer.

in order to authenticate requests you must add a callback in the main controller of your application
or in any other controller where you need SecureApi's functionality:

```ruby
class ApplicationController < ActionController::Base
  before_action :authenticate_request!
  # skip_before_action :authenticate_request! ## use this to skip authentication on specific requests
end
```

When making an authenticated requests, the `Authorization` header should be included, with your token.

In addition to authenticating the requests, SecureApi mounts a number of routes at `/user`, detailed documentation can be found [here](ROUTES.md)

## Extra

### User response

SecureApi controller responses that return a user, default to this JSON response:

```JSON
{
  "user": {
    "USER"
  },
  "token": {
    "token": "String",
    "expiration": "ISO8601"
  }
}
```

The USER defaults to the user instance without password and timestamps, this can be customized by creating an instance method in the user class named `secure_api_resonse` that returns a hash of attributes:

```ruby
class User < ApplicationRecord
  def full_name
    first_name + last_name
  end

  def secure_api_response
    {
      full_name: full_name
    }
  end
end
```

### Helpers

SecureApi provides some additional helpers.

To facilitate testing the `auth_headers` method is available in the `Minitest` suite:

```ruby
require 'test_helper'

class MyControllerTest < ActionDispatch::IntegrationTest
  test 'some url' do
    user = User.create
    headers = auth_headers(user)
    # headers is a hash, you can add any key you want
    headers[:another_header] = 'Something'

    get some_url, headers: headers
  end
end

```

If your project does not use `Minitest`, you must include these modules into your test suite of choice:

     SecureApi::Helpers::Test, SecureApi

In addition there is `authenticate_cable_request!` to authenticate ActionCable connections, given the token is included in the params (`wss://MY_OWN_DOMAIN/cable?Authorization=TOKEN`):

```ruby
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # authenticate_cable_request! returns the user, or false
      authenticate_cable_request! || reject_unauthorized_connection
    end
  end
end
```

### Secure token

The `secure_token` method is avilabe to the user instance, which returns a `SecureApi::Token` instance:

```ruby
user = User.first
user.secure_token

# <SecureApi::Token id: 1, token: "eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoxLCJleHAiOjE2MDYxM...", exp_date: "2020-11-23 13:26:13", resource_type: "User", resource_id: 1, created_at: "2020-11-22 13:26:13", updated_at: "2020-11-22 13:26:13">
```

## Development

After checking out the repo, run `bundle install` to install dependencies. You can also run `rails s` or `rails c` to run the server (Dummy app) or the console.

## Testing

To test the gem simply run `rails test` from the root of the library folder.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidmetta/secure_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
