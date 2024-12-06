module AuthenticationHelper
  def authenticate_user
    senha =  ENV["JWT_SECRET"]
      authenticate_or_request_with_http_token do |token, options|
        payload = JWT.decode(token, senha, true, { algorithm: 'HS256' })
        credenciais = payload[0]
        @login = Login.find_by(user: credenciais["usuario"])
        rescue JWT::ExpiredSignature
          render json: { error: "Token expirado" }, status: :unauthorized
        rescue JWT::DecodeError
          render json: { error: "Token inválido" }, status: :unauthorized
      end
  end
end