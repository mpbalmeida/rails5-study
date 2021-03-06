require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do
  describe 'include the correct concerns' do
    it { expect(controller.class.ancestors).to include(Authenticable) }
  end
end