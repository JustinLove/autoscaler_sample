require 'platform-api'

class HerokuLogs
  def initialize(
      token = ENV['HEROKU_ACCESS_TOKEN'],
      app = ENV['HEROKU_APP'])
    if token && app
      @url = PlatformAPI.connect_oauth(token)
        .log_session
        .create(app, {:lines => 50})['logplex_url']
    end
  end

  def all
    if @url
      Excon.get(@url).body.split("\n").map {|line| line.gsub /by [0-9A-Za-z._%+-]+@[0-9A-Za-z.-]+\.[A-Za-z]{2,6}/, 'by REDACTED'}
    else
      []
    end
  end

  def sidekiq
    all.select {|line|
      line.match(/INFO: (start|done)/) ||
        line.index('TWEET') ||
        line.index('Scale to')
    }
  end
end
