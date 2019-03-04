# README

* Ruby version
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16] 

* Rails version
Rails 5.1.6.1

* Gems added
group :production, :development, :test do
  gem 'pdf-reader'
  gem 'docraptor'
end
group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'rspec_api_documentation'
  gem 'apitome'
end

* How to run the test suite
bundle exec rspec

* How to build the API documentation
bundle exec rspec spec/pdf_metadata_spec.rb --format RspecApiDocumentation::ApiFormatter

