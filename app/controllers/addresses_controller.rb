class AddressesController < ApplicationController
  before_action :set_contact

# GET /address/1
  def show
    render json: @contact.address
  end

# POST /address 
  def create
    @contact.address = Address.new(address_params)
    if @contact.save
      render json: @contact.address, location: contact_address_url(@contact)
    else
      render json: @contact.errors, status: :created
    end
  end

# PATCH/PUT /address/1 
  def update
    if @contact.address.update(address_params)
      render json: @contact.address
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end


# DELETE /address/1  
  def destroy
    @contact.address.destroy
  end

  private
   
    def set_contact
        @contact = Contact.find(params[:contact_id])
    end

    def address_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
