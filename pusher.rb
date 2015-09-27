require 'sinatra'
require 'houston'

require_relative 'token_repository'

use Rack::Auth::Basic, "Pusher" do |username, password|
    username == ENV['USERNAME'] and password == ENV['PASSWORD']
end

get '/push' do
  email = params[:user]
  text = params[:text] || 'Hello, world!'
  uri = params[:uri] || ''

  token = TokenRepository.find_token for_email: email

  halt(400, 'Bad request') unless token

  APN = Houston::Client.development
  APN.certificate = ENV['CERTIFICATE']
  APN.passphrase = ENV['PASSPHRASE']

  notification = Houston::Notification.new(device: token)
  notification.alert = text
  notification.custom_data = {uri: uri}

  APN.push(notification)

  "Sent notification to #{email}."
end
