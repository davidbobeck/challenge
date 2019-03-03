module API
  module PdfMetadata

    #-------------------------------------
    def self.process(params)
      unless params.key?(:urls)
        return [{messge: 'Missing urls in request'}, :bad_request]
      end

      urls = params[:urls]
      pdf_details = details_from_urls(urls)
      
      # format the data for the api response
      grouped_details = pdf_details.group_by { |detail| detail.page_count }
      grouped_details.each { |key, urls| urls.sort! }

      [grouped_details, :ok]
    end

    #-------------------------------------
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
