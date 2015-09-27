require_relative '../token_repository'

describe 'Token repository' do
  let(:registered_email) { 'registered@test.com' }
  let(:non_registered_email) { 'non.registered@test.com' }

  let(:token) { 'token' }

  before do
    TokenRepository.register token: token, for_email: registered_email
  end

  context "given a registered email" do
    it "retrieves a token" do
      expect(TokenRepository.find_token for_email: registered_email).to eq(token)
    end
  end

  context "given a non registered email" do
    it "retrieves nothing" do
      expect(TokenRepository.find_token for_email: non_registered_email).to be(nil)
    end
  end
end
