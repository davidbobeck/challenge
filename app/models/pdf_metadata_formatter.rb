# This class represents the body of the response returned
# by GET pdf_metadata
class PdfMetadataFormatter
  attr_accessor :details

  #-------------------------------------
  # Organize the response per the challenge's description
  def as_json(options = {})
    grouped_details = details.group_by { |detail| detail.page_count }
    grouped_details.each { |key, urls| urls.sort! }
    grouped_details
  end

end
