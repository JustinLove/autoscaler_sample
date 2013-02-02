class Canery
  include Sidekiq::Worker

  def perform(queue, time)
    puts "TWEET from #{queue} #{Time.now.to_f - time}"
  end

  def self.enqueue!(queue)
    Sidekiq::Client.push(
      'class' => self,
      'args' => [queue, Time.now.to_f],
      'queue' => queue)
  end
end
