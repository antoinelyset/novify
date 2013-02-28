require 'external_apis/nova'
require 'external_apis/spotify'

class RadiosController < ApplicationController
  def index
    @radios = Radio.all
  end

  def show
    @radio = Radio.find(params[:id])
  end

  def create
    timestamp     = calculate_timestamp(params)
    @radio = Radio.new(name: "Nova : #{Time.at(timestamp)}")
    @radio.tracks = request_tracks(timestamp)
    @radio.tracks.each do |t|
      t.radio = @radio
      t.save
    end
    @radio.save
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
    nova_tracks = ExternalApis::Nova.fetch(timestamp)
    ExternalApis::Spotify.multiple_fetch(nova_tracks)
  end
end
