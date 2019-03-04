require "docraptor"

class DocRaptorWrapper

  #-------------------------------------
  # Cookbook call to get a PDF from DocRaptor
  def self.pdf_from_url(url)
    @docraptor ||= DocRaptor::DocApi.new

    @docraptor.create_doc(
      test:             true,
      document_url:     url,
      name:             'docraptor-ruby.pdf',
      document_type:    'pdf'
    )
  end

end
