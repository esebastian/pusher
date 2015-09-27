require_relative '../pusher'

describe 'Pusher' do
  def app
    Sinatra::Application
  end

  let(:email) { "test@test.com" }

  it 'tries to retrieve a token' do
    token_repository = class_double('TokenRepository').as_stubbed_const(transfer_nested_constants: true)
    expect(token_repository).to receive(:find_token).with(for_email: email)

    get "/push?user=#{email}"
  end

  context "when a token is retrieved" do
    it "pushes a notification" do
      token_repository = class_double('TokenRepository').as_stubbed_const(transfer_nested_constants: true)
      allow(token_repository).to receive(:find_token).and_return(:token)

      service = class_double('Houston::Client').as_stubbed_const(transfer_nested_constants: true)
      apn = instance_double('Houston::Client')
      expect(service).to receive(:development).and_return(apn)
      expect(apn).to receive(:push)

      get "/push?user=#{email}"
    end
  end

  context "when no token is retrieved" do
    it "doesn't push a notification" do
      service = class_double('Houston::Client').as_stubbed_const(transfer_nested_constants: true)
      expect(service).not_to receive(:development)

      get "/push?user=#{email}"
    end
  end
end
