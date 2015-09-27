class TokenRepository
  @data = {}

  def self.find_token for_email:
    @data[for_email]
  end

  def self.register token:, for_email:
    @data[for_email] = token
  end
end
