class LoginsController < ApplicationController
  before_action :set_login, only: %i[ create ]


  # POST /logins
  def create
    if  @login
      atutenticate(params[:user], params[:password])
    else
      render json: { erro: "Usuário não cadastrado!" }, status: 401
    end
  end


  private

  def atutenticate(user, password)
    senha =  ENV["JWT_SECRET"]
    if senha
      if @login.password == password

        credencial = { usuario: user, senha: password, exp: Time.now.to_i + 3600 }
        token = JWT.encode(credencial, senha, "HS256")
        render json: { token: token }
      else
        render json: { erro: "Usuário e Senha não coincidem!" }, status: 401
      end
    else
      render json: { erro: "Master Token não definido!" }
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_login
      @login = Login.find_by user: params[:user]
    end

    # Only allow a list of trusted parameters through.
    def login_params
      params.require(:login).permit(:user, :password)
    end
end
