# PorticorBombarder
    
encrypts activerecord attributes with Porticor's encrypted keys management.    
    
## Installation

Add this line to your application's Gemfile:

    gem 'porticor_bombarder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install porticor_bombarder

 create porticor_attrs.yml to your config folder of application with structure as given below.
 Here you need to define model and attributes which need to be encrypted.

```yml      
    ---
    :model_name_1:
    - attribute_name
    :model_name_2:
      :specific_pem_file_name:
      - attribute_name
      - attribute_name
    :model_name_3:
      :specific_pem_file_name:
      - attribute_name
      - attribute_name
    :model_name_4:
      :specific_pem_file_name:
      - attribute_name
      - attribute_name
      - attribute_name
```

 create porticor.yml to your config folder of application with structure as given below.
 Here you need to define porticor's instance url, key, secret.
 
```yml      
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'YOUR_PORTICOR_API_KEY'
       api_secret: 'YOUR_PORTICOR_API_SECRET'
       backup_enabled: true # true if FileSystem storage required.
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'YOUR_PORTICOR_API_KEY'
       api_secret: 'YOUR_PORTICOR_API_SECRET'
       backup_enabled: true # true if FileSystem storage required.
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'YOUR_PORTICOR_API_KEY'
       api_secret: 'YOUR_PORTICOR_API_SECRET'
       backup_enabled: true # true if FileSystem storage required.
     YOUR_RAILS_APP_ENVIRONMENT:
       api_url: 'https://xxxxxxxxxxx-xxxxxxxxxxx.d.porticor.net'
       api_key: 'YOUR_PORTICOR_API_KEY'
       api_secret: 'YOUR_PORTICOR_API_SECRET'
       backup_enabled: true # true if FileSystem storage required.
``` 

 For already existing records you need to run following rake task.
  
```ruby
    rake porticor_bombarder:encrypt
```
   
## To-do's

1. Implement CacheClass.
2. Backup key_pairs to AWS-S3.
 

## Contributing

1. Fork it ( https://github.com/rajeevkannav/porticor_bombarder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
