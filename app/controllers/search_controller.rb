class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:log]

  def log
    ip_address = request.remote_ip
    query = params[:query]

    begin
      SearchRecord.create!(query:, ip_address:)
      render json: { status: 'ok' }
    rescue StandardError => e
      logger.error "An error occurred while processing search query: #{query} - #{e.message}"
      render json: { error: 'An error occurred while processing the search query.' }, status: :unprocessable_entity
    end
  end

  def analytics
    @search_queries = SearchRecord.all
    render 'analytics'
  end
end
