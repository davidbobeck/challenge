class SwaggerController < ApplicationController

  #-------------------------------------
  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    SwaggerForSwaggerController,
    SwaggerForPdfController,
    SwaggerForPdfDetail,
    SwaggerForPdfError,
    # self
  ].freeze

  API_DOC_FILE = 'api-docs.json'.freeze

  #-------------------------------------
  # a container for swagger ui
  def index
    @api_docs_json_file = API_DOC_FILE
  end

  #-------------------------------------
  # This action converts the Swagger::Blocks
  # decordated classes into Swagger documentation.
  def make
    swagger_json = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES).to_json
    File.open(File.join('public', 'docs', API_DOC_FILE), 'w') { |file| file.write(swagger_json) }
    redirect_to :swagger_view
  end

end
