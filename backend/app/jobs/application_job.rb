class ApplicationJob
  include Sidekiq::Job

  sidekiq_options retry: 10

  sidekiq_retry_in do |count|
    count**4
  end
end
