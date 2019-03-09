class PdfError < RuntimeError
  attr_accessor :status, :context, :message, :hint

  #-------------------------------------
  def initialize(options = {})
    options.each { |key, value| send("#{key}=", value) if self.respond_to?(key.to_sym) }
  end
end