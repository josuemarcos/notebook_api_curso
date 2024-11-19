class AddressesController < ApplicationController
  before_action :set_contact

# GET /address/1
  def show
    render json: @contact.address
  end

# POST /address 
  def create
    cep = params[:cep]
    endereco = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
    if endereco.code == 200
      cadastra_endereco(endereco["logradouro"], endereco["localidade"])
    else
      render  json: {erro: "CEP inválido!"}, status: 400
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
      #ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      params.require(:address).permit(:street, :city)
    end

    def cadastra_endereco(street, city)
      address_params = {street: street, city: city}
      @contact.address = Address.new(address_params)
      if @contact.save
        render json: @contact.address, location: contact_address_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    
end
