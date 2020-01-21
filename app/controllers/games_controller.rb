class GamesController < ApplicationController
  def index
  end

  def start
    @current_user = User.find(session[:current_user_id])
    # num_combo = Resque.enqueue(NumberGenerator)
    @msg =  NumberGenerator.perform()
  end

end
