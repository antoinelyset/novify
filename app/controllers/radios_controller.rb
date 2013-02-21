require 'external_apis/nova'
require 'external_apis/spotify'

class RadiosController < ApplicationController
  def index
    @radios = Radio.all
  end

  def show
    @radio = Radio.find(params[:id])
    render :show
  end

  def create
    timestamp     = calculate_timestamp(params)
    @radio.tracks = request_tracks(timestamp)
    @radio = Radio.new(name: "Nova : #{Time.at(timestamp)}")
    #refactor @radio.tracks = tracks
    tracks.each do |t|
      t.radio = @radio
      t.save
    end

    redirect_to @radio
  end

private
  def calculate_timestamp(params)
    date = Time.parse(params[:date])
    time = Time.parse(params[:time])
    Time.new(date.year, date.month, date.day, time.hour,
             time.min, time.sec, time.utc_offset).to_i
  end

  def request_tracks(timestamp)
    nova_tracks = ExternalApis::Nova.new(timestamp).tracks
    ExternalApis::Spotify.new(nova_tracks).tracks
  end
end
