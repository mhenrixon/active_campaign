[![Circle CI](https://circleci.com/gh/RushPlay/active_campaign.png?circle-token=908def2d4311fcbe28d2caabccaa703e2835cf37)](https://circleci.com/gh/RushPlay/active_campaign/tree/master)[![Coverage Status](https://coveralls.io/repos/RushPlay/active_campaign/badge.png?branch=master)](https://coveralls.io/r/RushPlay/active_campaign?branch=master) [![Code Climate](https://codeclimate.com/repos/525d012ec7f3a335f101a3d6/badges/74d14b105bf9f769f10f/gpa.png)](https://codeclimate.com/repos/525d012ec7f3a335f101a3d6/feed)
# Active::Campaign::Ruby

A simple wrapper for the ActiveCampaign API. Since their API seems to be
basically just form posts to their server don't complain here about the way it
works. The only thing we really changed was how results are wrapped and
returned and you can read more about that here.

## Installation

Add this line to your application's Gemfile:

    gem 'active_campaign'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_campaign

## Usage

Read their [API documentation](http://www.activecampaign.com/api/overview.php)for how to use this gem.

```ruby
# To fetch all lists
ActiveCampaign.list_list ids: 'all'
```

```ruby
# To sync a contact (create if doesn't exist or update if matching email)
# you have to resort to some really ugly hacks. Due to the form serialization # type of API (read not a object oriented REST API) you need to translate
# something pretty into something horrific when it comes to the parameters.
ActiveCampaign.contact_sync({
                                     "id" => user.active_campaign_contact_id,
                                  "email" => user.email,
                             "first_name" => user.first,
                              "last_name" => user.last,
     "p[#{user.active_campaign_list_id}]" => user.active_campaign_list_id,
"status[#{user.active_campaign_list_id}]" => user.receive_emails ? 1 : 2
})

# Another example of syncing a contact:

list_params = {
  "#{user.active_campaign_list_id}" => user.active_campaign_list_id,
             "#{user.other_list_id}" => user.other_list_id,
}

status_params = {
  "#{user.active_campaign_list_id}" => user.receive_emails ? 1 : 2,
             "#{user.other_list_id}" => true ? 1 : 2,
}

ActiveCampaign.contact_sync({
        "id" => user.active_campaign_contact_id,
     "email" => user.email,
"first_name" => user.first,
 "last_name" => user.last,
         "p" => list_params
    "status" => status_params
})
```

## Response

All responses are wrapped under `results` so
`ActiveCampaign.list_list ids: 'all'` returns

```ruby
{
     "result_code" => 1,
  "result_message" => "Success: Something is returned",
   "result_output" => "json",
         "results" => [
    {
                    "id" => "1",
                  "name" => "One list",
                 "cdate" => "2013-05-22 10:07:36",
               "private" => "0",
                "userid" => "1",
      "subscriber_count" => 2
    },
    {
                    "id" => "2",
                  "name" => "Another List",
                 "cdate" => "2013-05-22 10:09:15",
               "private" => "0",
                "userid" => "1",
      "subscriber_count" => 0
    }
  ]
}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Rebase against master we want 1 commit per feature please
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
