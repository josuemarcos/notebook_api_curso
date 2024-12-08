class ContactsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include AuthenticationHelper
  before_action :authenticate_user
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

    cep = params[:address_attributes][:cep]
    endereco = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")

    if endereco.code == 200
      cadastra_endereco(endereco["logradouro"], endereco["localidade"])
    else
      render  json: {erro: "CEP inválido!"}, status: 400
      return
    end

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

  def search
    term = params[:q] 
    @contacts = Contact.search(term) 
    render json: @contacts, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private


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

    def cadastra_endereco(street, city)
      address_params = {street: street, city: city}
      @contact.address = Address.new(address_params)
    end

end
