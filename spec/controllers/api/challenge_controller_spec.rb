RSpec.describe "API Challenge", type: 'request' do

  context 'when passing no urls' do
    it 'should return a 400 status' do
      get '/pdf_metadata'
      expect(response).to have_http_status(:bad_request)
    end

    it 'should return message about missing urls' do
      get '/pdf_metadata'
      json = JSON.parse(response.body)
      expect(json["message"]).to eq('Missing urls in request') 
    end
  end

  context 'when passing valid urls' do
    let!(:mock_file) { "spec/fixtures/pdf_metadata_mock.pdf" }
    let!(:mock_data) { File.read(mock_file) }
    let!(:result_file) { "spec/fixtures/pdf_metadata_result.json" }
    let!(:result_data) { File.read(result_file) }

    it 'should return a 200 status and json matching our fixture file' do
      allow(DocRaptorWrapper).to receive(:pdf_from_url).and_return(mock_data)
      get '/pdf_metadata?urls[]=spec/fixtures/pdf_metadata_mock.pdf'
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(result_data)
    end
  end

  context 'when pdf-reader raises a MalformedPDFError' do
    let!(:mock_file) { "spec/fixtures/pdf_metadata_mock.pdf" }
    let!(:mock_data) { File.read(mock_file) }

    it "we should see 'corrupt' in the error message in the json" do
      allow(DocRaptorWrapper).to receive(:pdf_from_url).and_return(mock_data)
      allow(PdfReaderWrapper).to receive(:detail_from_reader).and_raise(PDF::Reader::MalformedPDFError)
      get '/pdf_metadata?urls[]=abc.pdf'
      message = JSON.parse(response.body)["0"][0]["error"]
      expect(message).to match(/corrupt/)
    end
  end

  context 'when pdf-reader raises a UnsupportedFeatureError' do
    let!(:mock_file) { "spec/fixtures/pdf_metadata_mock.pdf" }
    let!(:mock_data) { File.read(mock_file) }

    it "we should see 'not supported' in the error message in the json" do
      allow(DocRaptorWrapper).to receive(:pdf_from_url).and_return(mock_data)
      allow(PdfReaderWrapper).to receive(:detail_from_reader).and_raise(PDF::Reader::UnsupportedFeatureError)
      get '/pdf_metadata?urls[]=abc.pdf'
      message = JSON.parse(response.body)["0"][0]["error"]
      expect(message).to match(/not supported/)
    end
  end
end
