class Api::V1::PdfController < ActionController::API

  #-------------------------------------
  # The challenge API endpoint. This endpoint
  # returns PDF metadata per the challenge's
  # described formatting requirements.
  def pdf_metadata
    json, status = Api::V1::PdfMetadata.process_for_json(params)
    render json: json, status: status
  end

end
