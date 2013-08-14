#if ENV['RAILS_ENV'] == 'production'
  #Excon.defaults[:ssl_verify_peer] = true
#else
  #Excon.defaults[:ssl_verify_peer] = false
#end

require 'sidekiq'
require 'autoscaler/sidekiq'
require 'autoscaler/heroku_scaler'

heroku = nil
if ENV['HEROKU_APP']
  heroku = Autoscaler::HerokuScaler.new
end

Sidekiq.configure_client do |config|
  if heroku
    config.client_middleware do |chain|
      chain.add Autoscaler::Sidekiq::Client, 'default' => heroku
    end
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    if heroku
      p "[Sidekiq] Running on Heroku, autoscaler is used"
      chain.add(Autoscaler::Sidekiq::Server, heroku, 1) # 1 minute timeout # wrong, 1 second
    else
      p "[Sidekiq] Running locally, so autoscaler isn't used"
    end
  end
end
