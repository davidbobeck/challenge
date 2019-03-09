class PdfReaderWrapper

  #-------------------------------------
  # Use the pdf-reader gem to pull details
  # out of the pdf we got from DocRaptor 
  def self.detail_from_pdf(url, pdf_data)
    io = StringIO.new(pdf_data, 'rb')
    reader = PDF::Reader.new(io)
    detail_from_reader(url, reader)

  rescue PDF::Reader::MalformedPDFError => e
    raise PdfError.new({ context: url, message: 'The PDF appears to be corrupt in some way.', status: :bad_request })
  rescue PDF::Reader::UnsupportedFeatureError => e
    raise PdfError.new({ context: url, message: 'The PDF uses a feature that is currently not supported.', status: :bad_request })
  end

  #-------------------------------------
  # Create a PdfDetail and populate it
  # with properties from the reader
  def self.detail_from_reader(url, reader)
    PdfDetail.new.tap do |detail|
      detail.url = url
      detail.pdf_version = reader.pdf_version
      detail.page_count = reader.pages.count
      detail.info = reader.info
      detail.metadata = reader.metadata
    end
  end

end
