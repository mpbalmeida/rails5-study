require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } 

  it {expect(user).to validate_presence_of(:email)}
  it {expect(user).to validate_uniqueness_of(:email).case_insensitive}
  it {expect(user).to validate_confirmation_of(:password)}
  it {expect(user).to allow_value('patu.duck@gmail.com').for(:email)}
  it {expect(user).to validate_uniqueness_of(:auth_token)}

  describe '#info' do
    it 'returns email, created_at and token' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end
end
