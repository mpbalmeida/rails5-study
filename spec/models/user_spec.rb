require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } 

  it { is_expected.to have_many(:tasks).dependent(:destroy) }

  it {expect(user).to validate_presence_of(:email)}
  it {expect(user).to validate_uniqueness_of(:email).case_insensitive}
  it {expect(user).to validate_confirmation_of(:password)}
  it {expect(user).to allow_value('patu.duck@gmail.com').for(:email)}
  it {expect(user).to validate_uniqueness_of(:auth_token)}

  describe '#info' do
    it 'returns email, created_at and token' do
      user.save! #precisa que usuario seja salvo, senão ele será executado na hora da chamada
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end

  describe '#generate_authentication_token!' do #Esse método vai alterar o estado do objeto !
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xyzTOKEN')
    end

    it 'generates another auth token when the current auth token already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN', 'abc123xyzTOKEN', 'terceiroTOKEN')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end
