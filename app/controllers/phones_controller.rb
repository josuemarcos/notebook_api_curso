class PhonesController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include AuthenticationHelper
  before_action :authenticate_user
  before_action :set_contact

  def index
    if @contact.login_id == @login.id
      render json: @contact.phones
    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
  end


# GET contacts/phones/1
  def show
    
    if @contact.login_id == @login.id
      render json: @contact.phones.find(params[:id])
    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end
    
  end

# POST contacts/phones 
  def create

    if @contact.login_id == @login.id

      @contact.phones << Phone.new(phone_params)
      
      if @contact.save
        render json: @contact.phones, location: contact_phones_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end

    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end

    
  end

# PATCH/PUT /phone/1 
  def update
    
    if @contact.login_id == @login.id

      if @contact.phones.find(params[:id]).update(phone_params)
        render json: @contact.phones.find(params[:id])
      else
        render json: @contact.errors, status: :unprocessable_entity
      end

    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end


    
  end

# DELETE /phone/1  
  def destroy
    if @contact.login_id == @login.id
      @contact.phones.find(params[:id]).destroy
    else 
      render json: {erro: "Contato não encontrado!"},  status: 404
    end

    
  end


  private
   
    def set_contact
        @contact = Contact.find(params[:contact_id])
    end

    def phone_params
      params.require(:phone).permit(:number)
    end
    

end
