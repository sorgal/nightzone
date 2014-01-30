module ApplicationHelper

  def broadcast
    message = {:channel => '/games', :data => "alert(1)"}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
