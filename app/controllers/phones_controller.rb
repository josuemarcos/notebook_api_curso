class PhonesController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  TOKEN = "secret123"

  before_action :authenticate, only: [:show]
  before_action :set_contact

  def index
    render json: @contact.phones
  end


# GET contacts/phones/1
  def show
    render json: @contact.phones.find(params[:id])
  end

# POST contacts/phones 
  def create
    @contact.phones << Phone.new(phone_params)

    if @contact.save
      render json: @contact.phones, location: contact_phones_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

# PATCH/PUT /phone/1 
  def update
    
    if @contact.phones.find(params[:id]).update(phone_params)
      render json: @contact.phones
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

# DELETE /phone/1  
  def destroy
    @contact.phones.find(params[:id]).destroy
  end


  private
   
    def set_contact
        @contact = Contact.find(params[:contact_id])
    end

    def phone_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        # Compare the tokens in a time-constant manner, to mitigate
        # timing attacks.
        ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
      end
    end

    
end
