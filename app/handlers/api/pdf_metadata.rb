module Api
  module PdfMetadata

    #-------------------------------------
    # Handles processing for the
    # /pdf_metadata API endpoint 
    def self.process(params)
      unless params.key?(:urls) && !params[:urls].blank?
        return [{message: 'Missing urls in request'}, :bad_request]
      end

      # debugging short circuit 
      # return [{message: 'good'}, 200]

      # pull the urls out of the request
      urls = params[:urls]

      # convert the urls into a collection of PdfDetail objects
      pdf_details = details_from_urls(urls)
      
      # format the data for the api response.
      # group by page_count and sort the groups by url
      grouped_details = pdf_details.group_by { |detail| detail.page_count }
      grouped_details.each { |key, urls| urls.sort! }

      [grouped_details, :ok]
    end

    #-------------------------------------
    # Run the urls thru DocRaptor and pdf-reader
    # and generate an array of PdfDetail objects
    def self.details_from_urls(urls)
      urls.map do |url|
        begin
          pdf_data = DocRaptorWrapper.pdf_from_url(url)
          PdfReaderWrapper.detail_from_pdf(url, pdf_data)
        rescue DocRaptor::ApiError => e
          PdfReaderWrapper.detail_with_error(url, e.message)
        end  
      end
    end

  end
end
