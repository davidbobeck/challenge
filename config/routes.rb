Rails.application.routes.draw do

  # The default root takes us to a human facing welcome view
  root to: "welcome#index"
  
  # The challenge API
  get 'api/v1/pdf_metadata(/:urls)', to: 'api/v1/pdf#pdf_metadata' 

  # Temporary endpoint will generate documentation
  # Should be gated by admin access.
  # Should be a POST
  get '/docs/make', to: 'docs#make'

  # Show documentation using swagger ui
  get 'docs', to: 'docs#index', as: :swagger_view
end
