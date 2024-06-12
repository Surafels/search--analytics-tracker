require 'rails_helper'

RSpec.describe SearchRecord, type: :model do
  let(:valid_search_record) { SearchRecord.new(query: 'example search', ip_address: '127.0.0.1') }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(valid_search_record).to be_valid
    end

    it 'is not valid without a query' do
      valid_search_record.query = nil
      expect(valid_search_record).not_to be_valid
      expect(valid_search_record.errors[:query]).to include("can't be blank")
    end

    it 'is not valid without an ip_address' do
      valid_search_record.ip_address = nil
      expect(valid_search_record).not_to be_valid
      expect(valid_search_record.errors[:ip_address]).to include("can't be blank")
    end

    it 'is not valid if query is not unique for the same ip_address' do
      SearchRecord.create!(query: 'example search', ip_address: '127.0.0.1')
      expect(valid_search_record).not_to be_valid
      expect(valid_search_record.errors[:query]).to include('has already been taken')
    end

    it 'is valid if query is unique for a different ip_address' do
      SearchRecord.create!(query: 'example search', ip_address: '127.0.0.2')
      expect(valid_search_record).to be_valid
    end
  end
end
