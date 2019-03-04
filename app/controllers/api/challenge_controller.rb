class Api::ChallengeController < ActionController::API

  #-------------------------------------
  def pdf_metadata
    json, status = Api::PdfMetadata.process(params)
    render json: json, status: status
  end

end
