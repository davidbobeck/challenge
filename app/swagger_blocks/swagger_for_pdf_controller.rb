class SwaggerForPdfController
  include Swagger::Blocks

  swagger_path '/pdf_metadata' do
    operation :get do
      key :summary, 'Get metadata about one or more PDFs by URL'
      key :description, 'Returns metadata about each PDF identified by the provided URLs'
      # key :operationId, 'findPdfByUrl'
      # key :tags, [
      #   'pdf'
      # ]
      parameter do
        key :name, 'urls[]'
        key :in, :query
        key :description, 'List of URLs identifying PDFs to get details about'
        key :required, true
        key :type, :array
        key :collectionFormat, "multi"
        items do
          key :type, :string
        end
      end
      response 200 do
        key :description, 'PDF details grouped by page count'
        schema do
          key :type, :object
          key :example, {
                          '1': [
                            {
                              url: 'http://somewhere/abc.pdf',
                              pdf_version: '1.0.1',
                              page_count: 1,
                              info: 'This is abc.pdf which has one page',
                              metadata: nil
                            },
                            {
                              url: 'http://somewhere/def.pdf',
                              pdf_version: '1.2.1',
                              page_count: 1,
                              info: 'This is def.pdf which has one page',
                              metadata: nil
                            }
                          ],
                          '3': [
                            {
                              url: 'http://somewhere/xyz.pdf',
                              pdf_version: '2.0.1',
                              page_count: 3,
                              info: 'This is xyz.pdf which has three pages',
                              metadata: nil
                            }
                          ]
                        }
        end
      end
      response 404 do
        key :description, 'Something you sent us is messed up'
        schema do
          key :'$ref', :PdfError
        end
      end
    end
  end

end
