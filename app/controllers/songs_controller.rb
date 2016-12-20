class SongsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @songs = Song.all
  end

  def create
    @song = Song.new(artist: params[:artist], title: params[:title])
    if @song.valid?
      @song.save
      redirect_to :back
    else
      flash[:errors] = @song.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @song = Song.find(params[:id])
    @person_added = Playlist.select('*').joins(:user).where(song: @song)
    # binding.pry
    render 'show'
  end
end
