class OpenGraph
  def self.post_new_team(request, session, team)
      oauth_token = session["oauth_token"]
      if oauth_token
        callback_url = "#{request.protocol}#{request.host_with_port}/teams/#{team.id}"
        Rails.logger.debug "facebook team callback_url #{callback_url}"
        graph = Koala::Facebook::API.new(oauth_token)
        Thread.new {
          graph.put_connections("me", "#{FB_APP_NAMESPACE}:create", :team => "#{callback_url}")
        }
      else
        puts "No oauth_token found!"
      end 
  rescue StandardError => e
    #Just report the error. We can move on without a facebook publish
    Rails.logger.error "Unable to post team to facebook, error : #{e}"
  end

  def self.post_new_person(request, session, person)
    #TODO need to handle oauth token expiration
    # this is failing silently after I think about an hour?
      oauth_token = session["oauth_token"]
      if oauth_token
        callback_url = "#{request.protocol}#{request.host_with_port}/people/#{person.id}"
        Rails.logger.debug "facebook person callback_url #{callback_url}"
        graph = Koala::Facebook::API.new(oauth_token)
        Thread.new {
          graph.put_connections("me", "#{FB_APP_NAMESPACE}:create", :person => "#{callback_url}")
        }
      else
        puts "No oauth_token found!"
      end 
    rescue StandardError => e
      #Just report the error. We can move on without a facebook publish
      Rails.logger.error "Unable to post person to facebook, error : #{e}"
   end
end