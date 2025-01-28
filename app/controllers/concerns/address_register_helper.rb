module AddressRegisterHelper
  def register_address(cep)
    endereco = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")

    if endereco.code == 200
      cadastra_endereco(endereco["logradouro"], endereco["localidade"])
    else
      render  json: {erro: "CEP inválido!"}, status: 400
      return
    end
  end
end