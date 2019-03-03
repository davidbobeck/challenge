module PdfInvestigator

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
