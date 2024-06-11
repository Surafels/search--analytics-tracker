class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:log]

  def index; end

  def log
    ip_address = request.remote_ip
    query = params[:query]

    puts "Received query: #{query} from IP: #{ip_address}"

    SearchRecord.create(query:, ip_address:)
    render json: { status: 'ok' }
  end

  def analytics
    @search_queries = SearchRecord.all
    render 'analytics'
  end
end
