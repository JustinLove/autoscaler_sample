class JobsController < ApplicationController
  def create
    Canery.enqueue!(params[:queue])
    redirect_to root_path
  end

  private
  def logs
    HerokuLogs.new.sidekiq
  end
  helper_method :logs
end
