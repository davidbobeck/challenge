class SwaggerForPdfDetail
  include Swagger::Blocks

  swagger_schema :PdfDetail do
    key :required, [:url, :pdf_version, :page_count, :info, :metadata]
    property :url do
      key :type, :string
    end
    property :pdf_version do
      key :type, :string
    end
    property :page_count do
      key :type, :integer
      key :format, :int32
    end
    property :info do
      key :type, :object
    end
    property :metadata do
      key :type, :object
    end
  end
end
