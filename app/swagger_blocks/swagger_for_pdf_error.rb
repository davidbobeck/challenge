class SwaggerForPdfError
  include Swagger::Blocks

  swagger_schema :PdfError do
    key :required, [:context, :message]
    property :context do
      key :type, :string
    end
    property :message do
      key :type, :string
    end
  end
end
