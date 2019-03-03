class PdfDetail
  attr_accessor :url, :pdf_version, :page_count, :info, :metadata, :error

  #-------------------------------------
  def <=>(other)
    @url <=> other.url
  end

end
