class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    #render :text => "Hello World"
  end

  def show
    @playlist = Playlist.find(params[:id])
  end
end
