  # spec/pdf_metadata_spec.rb
  # require 'rails_helper'
  require "rspec_api_documentation"
  require "rspec_api_documentation/dsl"
  
  resource 'PDF Metadata' do

    explanation "by David Bobeck"
    header "Accept", "application/json"
    header "Content-Type", "application/json"

    get '/pdf_metadata' do

      # with_options scope: :data, with_example: true do
        parameter :urls, 'URLs to DocRaptor PDFs', required: true
      # end

      context "400" do
        let(:urls) { nil }

        example 'Invalid request: when no URLs are provided' do
          request = { urls: urls }
          do_request(request)
          expect(status).to eq(400)
        end
      end

      context "200" do
        let!(:dump_file) { "spec/fixtures/pdf_metadata_dump.json" }
        let!(:dump_data) { File.read(dump_file) }
        let(:urls) { ['http://docraptor.com/examples/invoice.html'] }

        example 'Valid request: when at least one URL is provided' do
          allow(Api::PdfMetadata).to receive(:process).and_return([dump_data, :ok])
          request = { urls: urls }
          do_request(request)
          
          expected_response = dump_data
          expect(status).to eq(200)
          expect(response_body).to eq(expected_response)
        end
      end

    end
  end