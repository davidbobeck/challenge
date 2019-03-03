class ChallengeController < ApplicationController

  #-------------------------------------
  def welcome
    render plain: 'Welcome to the challenge!'
  end

  #-------------------------------------
  def pdf_metadata
    unless params.key?(:urls)
      return render json: {messge: 'Missing urls in request'}, status: :bad_request
    end

    urls = params[:urls]
    pdf_details = PdfInvestigator.details_from_urls(urls)
    
    # format the data for the api response
    grouped_details = pdf_details.group_by { |detail| detail.page_count }
    grouped_details.each { |key, urls| urls.sort! }

    render json: grouped_details, status: :ok
  end

end
