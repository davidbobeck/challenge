# require 'open-uri'

class PdfReaderWrapper

  #-------------------------------------
  # Use the pdf-reader gem to pull details
  # out of the pdf we got from DocRaptor 
  def self.detail_from_pdf(url, pdf_data)
    io = StringIO.new(pdf_data, 'rb')
    reader = PDF::Reader.new(io)
    detail_from_reader(url, reader)

  # instead of aborting, pass the each error along to the caller
  rescue PDF::Reader::MalformedPDFError => e
    detail_with_error(url, "The PDF appears to be corrupt in some way.")
  rescue PDF::Reader::UnsupportedFeatureError => e
    detail_with_error(url, "The PDF uses a feature that is currently not supported.")
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

  #-------------------------------------
  # Pass the error captured from pdf-reader
  # to the caller using PdfDetail as a host 
  def self.detail_with_error(url, message)
    PdfDetail.new.tap do |detail|
      detail.url = url
      detail.error = message
      detail.page_count = 0
    end
  end

end
