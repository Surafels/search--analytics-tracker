class SearchRecord < ApplicationRecord
  validates :query, presence: true, uniqueness: { scope: :ip_address }
  validates :ip_address, presence: true
end
