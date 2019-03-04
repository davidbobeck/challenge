# spec/support/api_helper.rb

module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end