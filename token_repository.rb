require 'mongo'

class TokenRepository
  def self.db
    @db ||= Mongo::Client.new(ENV['MONGODB_URI'])
  end

  def self.find_token for_email:
    user = db[:users].find(:email => for_email).first
    user[:device_tokens].first unless user.nil?
  end

  def self.register token:, for_email:
    db[:users].update_one({ :email => for_email },
                          { :$push => { :device_tokens => token }},
                          { :upsert => true })
  end
end
