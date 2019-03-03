class ChallengeController < ApplicationController

  #-------------------------------------
  def welcome
    render plain: 'Welcome to the challenge!'
  end

  #-------------------------------------
  def pdf_metadata
    json, status = API::PdfMetadata.process(params)
    render json: json, status: status
  end

end
