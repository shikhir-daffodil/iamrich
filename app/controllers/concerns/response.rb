# app/controllers/concerns/response.rb
module Response

	# Check more statuses at "http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/"
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end 
