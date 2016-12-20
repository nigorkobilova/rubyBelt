class UsersController < ApplicationController
  def new
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/songs"
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to '/main'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to '/songs'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/main'
    end
  end

  def show
    @user = User.find(params[:id])
    @playlist = Playlist.select('*').joins(:song).where(user: @user)
    # binding.pry
    render 'show'
  end

  def logout
    session.clear
    redirect_to '/main'
  end
  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
