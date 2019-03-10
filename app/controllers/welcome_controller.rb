class WelcomeController < ApplicationController

  #-------------------------------------
  # This action provides a landing page
  # for developers interested in the API.
  # It is not required by the API, but could
  # become useful as the API grows in complexity.
  # Perhaps for FAQs or company info. 
  def index
    host_url = ENV['API_HOST_URL'] || 'localhost:3000'
    @api_root = File.join(host_url, 'api', 'v1', 'pdf_metadata')
  end

end