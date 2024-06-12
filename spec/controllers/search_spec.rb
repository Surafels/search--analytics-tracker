require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #log' do
    let(:valid_attributes) { { query: 'example query' } }

    it 'creates a new SearchRecord' do
      expect do
        post :log, params: valid_attributes
      end.to change(SearchRecord, :count).by(1)
    end

    it 'sets the correct attributes on the SearchRecord' do
      post :log, params: valid_attributes
      search_record = SearchRecord.last
      expect(search_record.query).to eq('example query')
      expect(search_record.ip_address).to eq(request.remote_ip)
    end

    it 'returns a JSON response with status ok' do
      post :log, params: valid_attributes
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to eq('status' => 'ok')
    end
  end
end
