require 'rails_helper'

RSpec.describe Api::V2::BaseController, type: :controller do
  describe 'include the correct concerns' do
    it { expect(controller.class.ancestors).to include(DeviseTokenAuth::Concerns::SetUserByToken) }
  end
end