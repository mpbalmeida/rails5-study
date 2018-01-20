class Api::V2::SessionsController < Api::V2::BaseController
    respond_to :json

    def create
        user = User.find_by(email: session_params[:email]) #find_by retorna nil caso não exista, find estoura exception

        #método do deviser para auxiliar validação de senha
        if user && user.valid_password?(session_params[:password]) 
            sign_in user, store: false
            user.generate_authentication_token! #renovar o token do usuário
            user.save
            render json: user, status: 200
        else
            render json: { errors: 'Invalid password or email'}, status: 401
        end
    end

    def destroy
        user = User.find_by(auth_token: params[:id])
        user.generate_authentication_token!
        user.save

        head 204
    end

    private

    def session_params
        params.require(:session).permit(:email, :password)
    end
end
