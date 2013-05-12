class HerokuLogs
  def initialize(
      key = ENV['HEROKU_API_KEY'],
      app = ENV['HEROKU_APP'])
    @url = Heroku::API.new(:api_key => key).get_logs(app).body
  end

  def all
    Excon.get(@url).body.split("\n").map {|line| line.gsub /by [0-9A-Za-z._%+-]+@[0-9A-Za-z.-]+\.[A-Za-z]{2,6}/, 'by REDACTED'}
  end

  def sidekiq
    all.select {|line|
      line.match(/INFO: (start|done)/) ||
        line.index('TWEET') ||
        line.index('Scale to')
    }
  end
end
