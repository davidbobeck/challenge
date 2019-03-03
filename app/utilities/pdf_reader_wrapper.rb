# require 'open-uri'

module PdfReaderWrapper

  #-------------------------------------
  def self.detail_from_pdf(url, pdf_data)
    io = StringIO.new(pdf_data, 'rb')
    reader = PDF::Reader.new(io)

    PdfDetail.new.tap do |detail|
      detail.url = url
      detail.pdf_version = reader.pdf_version
      detail.page_count = reader.pages.count
      detail.info = reader.info
      detail.metadata = reader.metadata
    end

  rescue PDF::Reader::MalformedPDFError => e
    detail_with_error(url, "The PDF appears to be corrupt in some way.")
  rescue PDF::Reader::UnsupportedFeatureError => e
    detail_with_error(url, "The PDF uses a feature that isn't currently supported.")
  rescue ArgumentError => e
    detail_with_error(url, "The PDF cannot be read because the url is missing or poorly formatted.")
  end

  #-------------------------------------
  def self.detail_with_error(url, message)
    PdfDetail.new.tap do |detail|
      detail.url = url
      detail.error = message
      detail.page_count = 0
    end
  end

end
