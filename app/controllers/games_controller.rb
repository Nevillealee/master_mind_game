class GamesController < ApplicationController
  def index
  end

  def start
    @current_user = User.find(session[:current_user_id])
    # TODO(Nlee): perform asynchronously
    num_combo =  NumberGenerator.perform()
    @game = @current_user.games.create(number_combo: num_combo)
  end

end
