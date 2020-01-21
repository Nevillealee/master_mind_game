class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(name: user_params['name'].strip)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to controller: :games, action: :index
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
