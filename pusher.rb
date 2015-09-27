require 'sinatra'
require 'houston'

require_relative 'token_repository'

get '/push' do
  email = params[:user]
  text = params[:text] || 'Hello, world!'
  uri = params[:uri] || ''

  token = TokenRepository.find_token_for(email)

  halt(400, 'Bad request') unless token

  APN = Houston::Client.development
  notification = Houston::Notification.new(device: token)
  notification.alert = text
  notification.custom_data = {uri: uri}

  APN.push(notification)
end
