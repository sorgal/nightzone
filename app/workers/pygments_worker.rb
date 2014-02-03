class PygmentsWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform
    puts "It works"
  end
end
