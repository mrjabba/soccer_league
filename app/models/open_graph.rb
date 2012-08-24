class OpenGraph
  attr_accessor :model, :graph_type_name

  def initialize(model)
    @model = model
  end

  def post_new_model(request, session)
      oauth_token = session["oauth_token"]
      if oauth_token
        callback_url = "#{request.protocol}#{request.host_with_port}/#{graph_type_name.pluralize}/#{@model.id}"
        Rails.logger.debug "facebook #{graph_type_name} callback_url #{callback_url}"
        graph = Koala::Facebook::API.new(oauth_token)
        Thread.new {
          graph.put_connections("me", "#{FB_APP_NAMESPACE}:create", 
            graph_type_name.to_sym => "#{callback_url}")
        }
      else
        Rails.logger.warn "OpenGraph: No oauth_token found!"
      end 
  rescue StandardError => e
    #Just report the error. We can move on without a facebook publish
    Rails.logger.error "Unable to post #{@model} to facebook, error : #{e}"
  end

  def graph_type_name
    @model.class.to_s.downcase
  end
end