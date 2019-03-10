class SwaggerForPdfController
  include Swagger::Blocks

  swagger_path '/pdf_metadata' do
    operation :get do
      key :summary, 'Get metadata about DocRaptor PDFs generated from one or more URLs'
      key :description, 'Returns metadata about each DocRaptor PDF generated from the provided URLs'
      # key :operationId, 'findPdfByUrl'
      # key :tags, [
      #   'pdf'
      # ]
      parameter do
        key :name, 'urls[]'
        key :in, :query
        key :description, 'List of HTML pages to be converted into PDF documents'
        key :required, true
        key :type, :array
        key :collectionFormat, "multi"
        items do
          key :type, :string
        end
      end
      response 200 do
        key :description, 'PDF details grouped by PDF page count'
        schema do
          key :type, :object
          key :example, {
                          '1': [
                            {
                              url: 'http://docraptor.com/examples/abc.html',
                              pdf_version: '1.5',
                              page_count: 1,
                              info: {
                                title: 'This is abc.pdf which has one page',
                                producer: 'some producer here'
                              },
                              metadata: nil
                            },
                            {
                              url: 'http://docraptor.com/examples/def.pdf',
                              pdf_version: '1.5',
                              page_count: 1,
                              info: {
                                title: 'This is def.pdf which has one page',
                                producer: 'some producer here'
                              },
                              metadata: nil
                            }
                          ],
                          '3': [
                            {
                              url: 'http://docraptor.com/examples/xyz.pdf',
                              pdf_version: '1.5',
                              page_count: 3,
                              info: {
                                title: 'This is xyz.pdf which has three pages',
                                producer: 'some producer here'
                              },
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
