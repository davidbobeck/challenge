RSpec.describe "API Challenge", type: 'request' do

  context 'when passing no urls' do
    before do
      get '/api/v1/pdf_metadata'
    end

    it 'return a 400 status' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'return message about missing urls' do
      json = JSON.parse(response.body)
      expect(json["message"]).to eq('missing urls in the request') 
    end
  end

  context 'when passing valid urls' do
    let!(:mock_file) { "spec/fixtures/pdf_metadata_mock.pdf" }
    let!(:mock_data) { File.read(mock_file) }
    let!(:result_file) { "spec/fixtures/pdf_metadata_result.json" }
    let!(:result_data) { File.read(result_file) }

    before do
      allow(DocRaptorWrapper).to receive(:pdf_from_url).and_return(mock_data)
      get '/api/v1/pdf_metadata?urls[]=spec/fixtures/pdf_metadata_mock.pdf'
    end

    it 'return a 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'return json matching our fixture file' do
      expect(response.body).to eq(result_data)
    end
  end

  context 'when pdf-reader raises a MalformedPDFError' do
    let!(:mock_file) { "spec/fixtures/pdf_metadata_mock.pdf" }
    let!(:mock_data) { File.read(mock_file) }

    before do
      allow(DocRaptorWrapper).to receive(:pdf_from_url).and_return(mock_data)
      allow(PdfReaderWrapper).to receive(:detail_from_reader).and_raise(PDF::Reader::MalformedPDFError)
      get '/api/v1/pdf_metadata?urls[]=abc.pdf'
    end
    
    it 'return a 400 status' do
      expect(response).to have_http_status(:bad_request)
    end

    it "JSON response body contains 'corrupt' in the error message" do
      message = JSON.parse(response.body)["message"]
      expect(message).to match(/corrupt/)
    end
  end

  context 'when pdf-reader raises a UnsupportedFeatureError' do
    let!(:mock_file) { "spec/fixtures/pdf_metadata_mock.pdf" }
    let!(:mock_data) { File.read(mock_file) }

    before do
      allow(DocRaptorWrapper).to receive(:pdf_from_url).and_return(mock_data)
      allow(PdfReaderWrapper).to receive(:detail_from_reader).and_raise(PDF::Reader::UnsupportedFeatureError)
      get '/api/v1/pdf_metadata?urls[]=abc.pdf'
    end

    it 'return a 400 status' do
      expect(response).to have_http_status(:bad_request)
    end

    it "JSON response body contains 'not supported' in the error message" do
      message = JSON.parse(response.body)["message"]
      expect(message).to match(/not supported/)
    end
  end
end
