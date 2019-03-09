class DocsController < ApplicationController

  #-------------------------------------
  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    SwaggerForDocsController,
    SwaggerForPdfController,
    SwaggerForPdfDetail,
    SwaggerForPdfError,
    # self
  ].freeze

  #-------------------------------------
  # This action converts the Swagger::Blocks
  # decordated classes into Swagger documentation.
  def make
    swagger_json = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES).to_json
    File.open('public/docs/api-docs.json', 'w') { |file| file.write(swagger_json) }
    redirect_to :swagger_view
  end

end
