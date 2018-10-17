# Requirements
* Ruby 2.5.1
* Rails 5.2.0

# Prepare
 ```
 bundle
 ```
 ```
 rails db:migrate
 ```

# Add into database
 
 ```
 rake parse:take_urls
 ```

# Deploy into json file
* Path to the file: ~/db/export/audio_info.json
 ```
 rake parse:make_json
 ```
