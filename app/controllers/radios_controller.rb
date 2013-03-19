require 'external_apis/nova'
require 'external_apis/spotify'

class RadiosController < ApplicationController
  def index
    @radios = Radio.order('started_at DESC').all
  end

  def show
    @radio = Radio.find(params[:id])
  end

  def create
    timestamp = calculate_timestamp(params)
    @radio = Radio.where(name: "Nova : #{l(Time.at(timestamp), format: :long)}").first_or_initialize
    @radio.save_with_tracks(request_tracks(timestamp)) unless @radio.persisted?

    redirect_to @radio
  end

private
  def calculate_timestamp(params)
    date = Time.zone.parse(params[:date])
    time = Time.zone.parse(params[:time])
    Time.new(date.year, date.month, date.day, time.hour,
             time.min, time.sec, time.utc_offset).to_i
  end

  def request_tracks(timestamp)
    nova_tracks = ExternalApis::Nova.fetch(timestamp)
    ExternalApis::Spotify.multiple_fetch(nova_tracks)
  end
end
