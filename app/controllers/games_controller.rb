class GamesController < ApplicationController
  def home
  end

  def index
    @current_user = User.find(session[:current_user_id])
    # TODO(Nlee): perform asynchronously
    num_combo =  NumberGenerator.perform()
    @game = @current_user.games.create(number_combo: num_combo)
    redirect_to @game
  end

  def show
    @current_game = Game.find(params[:id])
    @attempts_remaining = @current_game.attempts_remaining
  end

  def update
    # while attempts remaining and game isnt won
    @current_game = Game.find(params[:id])
    if @current_game.attempts_remaining > 0 && @current_game.won == false
      remaining = @current_game.attempts_remaining - 1
      @current_game.attempts_remaining = remaining
      @current_game.save!
      guess = params[:user_guess]
      result = @current_game.compare_answer(guess)
      attempt = 10 - @current_game.attempts_remaining
      # put feedback.result (derived from game.compare_answer response) in flash
      @feedback = @current_game.feedbacks.create(user_guess: guess, attempt: attempt, result: result)
      if @current_game.won
        # redirect to win screen and reveal number_combo
      else
        redirect_to @current_game
      end
    elsif @current_game.attempts_remaining < 1
      # redirect to game over screen
    end
  end

  private
  def game_params
    params.require(:game).permit(:id, :user_guess)
  end
end
