class PlaylistsController < ApplicationController
  def create
    @song_added = Playlist.new(user: User.find(current_user), song: Song.find(params[:song_id]))
    if @song_added.valid?
      @song_added.save
      redirect_to :back
    else
      flash[:errors] = @song_added.errors.full_messages
      redirect_to :back
    end
  end
end
