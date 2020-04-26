[![Build Status](https://travis-ci.org/mhenrixon/active_campaign.svg?branch=master)](https://travis-ci.org/mhenrixon/active_campaign)[![Code Climate](https://codeclimate.com/github/mhenrixon/active_campaign/badges/gpa.svg)](https://codeclimate.com/github/mhenrixon/active_campaign)[![Test Coverage](https://codeclimate.com/github/mhenrixon/active_campaign/badges/coverage.svg)](https://codeclimate.com/github/mhenrixon/active_campaign/coverage)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmhenrixon%2Factive_campaign.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmhenrixon%2Factive_campaign?ref=badge_shield)
# Active::Campaign::Ruby

A simple wrapper for the ActiveCampaign API. Since their API seems to be
basically just form posts to their server don't complain here about the way it
works. The only thing we really changed was how results are wrapped and
returned and you can read more about that here.

## Installation

Add this line to your application's Gemfile:

    gem 'active_campaign'

And then execute:

    bundle

Or install it yourself as:

    gem install active_campaign

## Usage

- [API documentation](https://developers.activecampaign.com/reference)
- [Gem documentation](https://mhenrixon.github.io/active_campaign)

```ruby
# To setup the client
client = ::ActiveCampaign::Client.new(
        api_url: 'YOUR-ENDPOINT', # e.g. 'https://youraccount.api-us1.com/api/3'
        api_token: 'YOUR-API-KEY') # e.g. 'a4e60a1ba200595d5cc37ede5732545184165e'

# or configure globally for all clients
::ActiveCampaign.configure do |config|
  config.api_url = 'YOUR-ENDPOINT' # e.g. 'https://youraccount.api-us1.com/api/3'
  config.api_token = 'YOUR-API-KEY' # e.g. 'a4e60a1ba200595d5cc37ede5732545184165e'
end

```

```ruby
# To create a contact
ActiveCampaign.create_contact(
  email: "mik@el.com", 
  first_name: "Mika",
  last_name: "El",
  phone: "bogusnumber",
)
```

```ruby
# To sync a contact (create if doesn't exist or update if matching email)
ActiveCampaign.sync_contact(
  email: "mik@el.com", 
  first_name: "Mika",
  last_name: "El",
  phone: "bogusnumber",
)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Rebase against master we want 1 commit per feature please
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmhenrixon%2Factive_campaign.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmhenrixon%2Factive_campaign?ref=badge_large)
