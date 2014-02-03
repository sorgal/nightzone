class PygmentsWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform
    message = {:channel => '/games', :data => "alert('It works!')"}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end
