# README

#### Ruby version 
``` 
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16] 
``` 

#### Rails version  
``` 
Rails 5.1.6.1
``` 

#### New rails application 
``` 
rails new challenge --skip-active-record
``` 

#### Gems added  
``` 
  gem 'pdf-reader'
  gem 'docraptor'
  gem 'rspec-rails'
  gem 'swagger-blocks'
``` 

#### Add swagger-ui to /public
git submodule add https://github.com/swagger-api/swagger-ui.git swagger

#### How to run the test suite  
``` 
bundle exec rspec
``` 

#### How to build the API documentation  
Temporary. 
* Should be moved behind admin access.
* Should be a POST.
``` 
GET /docs/make
``` 

