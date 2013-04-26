require 'sidekiq'
require 'autoscaler/sidekiq'
require 'autoscaler/heroku_scaler'
heroku = Autoscaler::HerokuScaler.new

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
  config.client_middleware do |chain|
    chain.add Autoscaler::Sidekiq::Client, 'default' => heroku
  end
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 4 }
  config.server_middleware do |chain|
    chain.add(Autoscaler::Sidekiq::Server, heroku, 30)
  end
end
