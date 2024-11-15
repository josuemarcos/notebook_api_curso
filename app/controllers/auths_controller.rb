class AuthsController < ApplicationController


  def create
    cep = params[:cep]
    endereco = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
    address_params = {street: endereco["logradouro"], city: endereco["localidade"]}
    if address_params[:street] && address_params[:city]
    render json: address_params
    else
      puts "CEP incorreto"
    end

  
    
  end
end
