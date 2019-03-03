Rails.application.routes.draw do
  get '/' => 'challenge#welcome' 
  get '/pdf_metadata(/:urls)' => 'challenge#pdf_metadata' 
end
