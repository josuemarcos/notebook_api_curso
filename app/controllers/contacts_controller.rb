class ContactsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :atutenticate
  before_action :set_contact, only: %i[ show update destroy ]

  # GET /contacts
  def index
    contatos = Contact.where(login_id: @login.id)
    render json: contatos
  end

  # GET /contacts/1
  def show
    if @contact.login_id == @login.id
      render json: @contact
    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    @contact.login_id = @login.id

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.login_id == @login.id
      if @contact.update(contact_params)
        render json: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
  end

  # DELETE /contacts/1
  def destroy

    if @contact.login_id == @login.id
      @contact.destroy!
    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
  end

  private

    def atutenticate
      senha =  ENV["JWT_SECRET"]
      authenticate_or_request_with_http_token do |token, options|
        # Compare the tokens in a time-constant manner, to mitigate
        # timing attacks.
        payload = JWT.decode(token, senha, true, { algorithm: 'HS256' })
        credenciais = payload[0]
        @login = Login.find_by(user: credenciais["usuario"])        
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :email, :birthdate, :kind_id, :login_id,
      phones_attributes: %i[ id number _destroy],
      address_attributes: %i[id street city])
    end
end
