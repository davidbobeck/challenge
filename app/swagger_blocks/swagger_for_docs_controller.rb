class SwaggerForDocsController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Coding Challenge'
      key :description, 'A mashup of DocRaptor (https://docraptor.com) and PDF::Reader (https://github.com/yob/pdf-reader)'
      # key :termsOfService, 'http://somewhere.com/terms/'
      contact do
        key :name, 'David Bobeck'
      end
      # license do
      #   key :name, 'MIT'
      # end
    end
    tag do
      key :name, 'DocRaptor'
      key :description, 'The best API for creating PDF and Excel files.'
      externalDocs do
        key :description, 'Find more info here'
        key :url, 'https://docraptor.com'
      end
    end
    tag do
      key :name, 'PDF::Reader'
      key :description, 'A library that implements a PDF parser conforming as much as possible to the PDF specification from Adobe.'
      externalDocs do
        key :description, 'Find more info here'
        key :url, 'https://github.com/yob/pdf-reader'
      end
    end
    # key :host, 'challenge.davidbobeck.com'
    key :host, ENV['API_HOST_URL'] || 'localhost:3000'
    key :basePath, '/api/v1'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

end
