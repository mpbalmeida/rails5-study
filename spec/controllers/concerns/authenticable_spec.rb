require 'rails_helper'

RSpec.describe Authenticable do
    #Simular um controle anonimo que herda de ApplicationController
    controller(ApplicationController) do 
        include Authenticable
    end

    let(:app_controller) { subject }

    describe '#current_user' do
        let(:user) { create(:user) }

        before do
            #objeto duble do request que contem o cabeçalho authorizarion e o token do usuario do teste
            req = double(:headers => { 'Authorization' => user.auth_token } ) 
            allow(app_controller).to receive(:request).and_return(req)
        end

        it 'returns the user from the authorization header' do
            expect(app_controller.current_user).to eq(user)
        end
    end
end