class GamesController < ApplicationController
  def home
    @best_games = Game.find_by_sql(
      "select * from games where won = true order by difficulty DESC, attempts_remaining desc limit 3;"
    )
    @difficulty = {4 => "Easy", 5 => "Medium", 6 => "Hard", 7 => "Ludicrous"}
  end

  def index
    @current_user = User.find(session[:current_user_id])
    # TODO(Nlee): perform asynchronously
    num_combo =  NumberGenerator.perform(session[:difficulty])
    @game = @current_user.games.create(number_combo: num_combo, difficulty: session[:difficulty])
    redirect_to @game
  end

  def show
    @current_game = Game.find(params[:id])
    @attempts_remaining = @current_game.attempts_remaining
    @all_feedback = @current_game.feedbacks.all
  end

  def update
    # while attempts remaining and game isnt won
    @current_game = Game.find(params[:id])
    remaining = @current_game.attempts_remaining - 1
    @current_game.attempts_remaining = remaining
    @current_game.save!

    guess = game_params[:user_guess]
    @result = @current_game.compare_answer(guess)
    attempt = 10 - @current_game.attempts_remaining
    @feedback = @current_game.feedbacks.create(user_guess: guess, attempt: attempt, result: @result)

    if @current_game.won
      flash[:notice] = @result
      # redirect to win screen and reveal number_combo
      redirect_to root_path
    elsif @current_game.attempts_remaining > 0 && @current_game.won == false
      flash[:notice] = @result
      redirect_to @current_game
    else
      # redirect to game over screen
      flash[:alert] = "GAME OVER...Please try again"
      redirect_to root_path
    end
  end

  private
  def game_params
    params.require(:game).permit(:id, :user_guess)
  end
end
