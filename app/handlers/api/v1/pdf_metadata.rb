module Api
  module V1
    module PdfMetadata

      #-------------------------------------
      # Handles json processing for the
      # /pdf_metadata API endpoint 
      def self.process_for_json(params)
        unless params.key?(:urls) && !params[:urls].blank?
          return [{context: 'get pdf_metadata', message: 'missing urls in the request'}, :bad_request]
        end
        # unless params.key?(:urls) && !params[:urls].blank?
        #   error = PdfError.new.tap do |error|
        #             error.message = 'get pdf_metadata'
        #             error.context = 'missing urls in the request'
        #           end
        #   return [error.to_json, :bad_request]
        # end

        # debugging short circuit 
        # return [{message: 'good'}, 200]

        # pull the urls out of the request
        urls = params[:urls]

        # convert the urls into a collection of PdfDetail objects
        begin
          pdf_details = details_from_urls(urls)
        rescue PdfError => e
          return [{context: e.context, message: e.message}, e.status]
        end  
      
        # format the response
        grouped_details = PdfMetadataFormatter.new.tap do |bundle|
          bundle.details = pdf_details
        end

        [grouped_details, :ok]
      end

      #-------------------------------------
      # Run the urls thru DocRaptor and pdf-reader
      # and generate an array of PdfDetail objects
      def self.details_from_urls(urls = [])
        urls.map do |url|
          begin
            pdf_data = DocRaptorWrapper.pdf_from_url(url)
            PdfReaderWrapper.detail_from_pdf(url, pdf_data)
          rescue DocRaptor::ApiError => e
            raise PdfError.new({ context: url, message: e.message, status: :bad_request })
          end  
        end
      end

    end
  end
end
