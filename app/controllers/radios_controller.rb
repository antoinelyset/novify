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
    date = Time.parse(params[:date])
    time = Time.parse(params[:time])
    complete_time = Time.new(date.year, date.month, date.day, time.hour,
                              time.min, time.sec, time.utc_offset)
    tracks = ExternalApis::Spotify.new(ExternalApis::Nova.new(complete_time.to_i).tracks).tracks

    @radio = Radio.new(name: "Nova : #{complete_time}")
    tracks.each do |t|
      t.radio = @radio
      t.save
    end

    render :show
  end
end
