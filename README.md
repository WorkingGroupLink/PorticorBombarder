# PorticorBombarder
    
    encrypts activerecord attributes with Porticor's encrypted keys management.    
    
## Installation

Add this line to your application's Gemfile:

    gem 'porticor_bombarder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install porticor_bombarder

## Usage
 create db_encryption.yml to your config folder of application with structure as given below.
 Here you need to define model and attributes which need to be encrypted.
      
    ---
    :model_name:
    - attribute_name
    :model_name:
      :specific_pem_file_name:
      - attribute_name
      - attribute_name
    :avatar:
      :specific_pem_file_name:
      - attribute_name
      - attribute_name
    :assistant:
      :specific_pem_file_name:
      - attribute_name
      - attribute_name
      - attribute_name

 create porticor.yml to your config folder of application with structure as given below.
 Here you need to define porticor's instance url, key, secret.
 
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'XtRFf04p4m8xdiLX'
       api_secret: 'Kane4BVE7untq3FV5Bm0WRgK1yvQUWq5'
       backup_enabled: true #true if FileSystem storage required.
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'XtRFf04p4m8xdiLX'
       api_secret: 'Kane4BVE7untq3FV5Bm0WRgK1yvQUWq5'
       backup_enabled: true #if FileSystem storage required.
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'XtRFf04p4m8xdiLX'
       api_secret: 'Kane4BVE7untq3FV5Bm0WRgK1yvQUWq5'
       backup_enabled: true #true if FileSystem storage required.
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'YOUR_PORTICOR_API_KEY'
       api_secret: 'YOUR_PORTICOR_API_SECRET'
       backup_enabled: true # true if FileSystem storage required.

    

## Contributing

1. Fork it ( https://github.com/rajeevkannav/porticor_bombarder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
