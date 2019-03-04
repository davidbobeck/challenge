Rails.application.routes.draw do
  get '/' => 'welcome#index' 
  get '/pdf_metadata(/:urls)' => 'api/challenge#pdf_metadata' 
end
