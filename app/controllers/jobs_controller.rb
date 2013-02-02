class JobsController < ApplicationController
  def create
    Canery.enqueue!(params[:queue])
    redirect_to root_path
  end
end
