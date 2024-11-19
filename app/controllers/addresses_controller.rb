class AddressesController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :atutenticate
  before_action :set_contact

# GET /address/1
  def show

    if @contact.login_id == @login.id
      render json: @contact.address
    else
      render json: {erro: "Contato não encontrado!"},  status: 404
    end

  end

# POST /address 
  def create
    if  @contact.login_id == @login.id
      cep = params[:cep]
      endereco = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
      if endereco.code == 200
        cadastra_endereco(endereco["logradouro"], endereco["localidade"])
      else
        render  json: {erro: "CEP inválido!"}, status: 400
      end
    else
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
  end

# PATCH/PUT /address/1 
  def update

    if  @contact.login_id == @login.id

      if @contact.address.update(address_params)
        render json: @contact.address
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    else
      render json: {erro: "Contato não encontrado!"},  status: 404
    end

  end


# DELETE /address/1  

  def destroy
    if  @contact.login_id == @login.id
      @contact.address.destroy
    else
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
  end

  private
   
    def set_contact
        @contact = Contact.find(params[:contact_id])
    end

    def atutenticate
      senha =  ENV["JWT_SECRET"]
      authenticate_or_request_with_http_token do |token, options|
        payload = JWT.decode(token, senha, true, { algorithm: 'HS256' })
        credenciais = payload[0]
        @login = Login.find_by(user: credenciais["usuario"])        
      end
    end

    def address_params
      #ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      params.require(:address).permit(:street, :city)
    end

    def cadastra_endereco(street, city)
      address_params = {street: street, city: city}
      @contact.address = Address.new(address_params)
      if @contact.save
        render json: @contact.address
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    
end
