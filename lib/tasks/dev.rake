namespace :dev do
  desc "Povoa o recurso Contact"
  task init_contacts: :environment do
     puts "Cadastrando contatos..."
    10.times do
      kinds = Kind.all
      kinds[Random.rand(3)].contacts.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago)
      )
    end
    puts "Contatos cadastrados com sucesso!"
  end
end

namespace :dev do
  desc "Gera dados mockados para o recurso Kinds"
  task init_kinds: :environment do
    puts "Cadastrando tipos de contatos..."

    kinds = [ "Outros", "Clientes", "Distribuidores", "Colaboradores" ]
    kinds.each do |kind|
      Kind.create!(description: kind)
    end
    puts "Tipos de contatos cadastrados com sucesso!"
  end
end

namespace :dev do
  desc "Gera dados mockados para o recurso Phone"
  task init_phones: :environment do
    puts "Cadastrando Telefones..."

    Contact.all.each do |contact|
      Random.rand(5).times do
        contact.phones.create!(number: Faker::PhoneNumber.cell_phone)
        contact.save!
      end
    end
    puts "Telefones cadastrados com sucesso!"
  end
end

namespace :dev do
  desc "Gera dados mockados para o recurso Address"
  task init_addresses: :environment do
    puts "Cadastrando Endereços..."

    Contact.all.each do |contact|
        Address.create(
          street: Faker::Address.street_address,
          city: Faker::Address.city,
          contact: contact)
    end
    puts "Endereços cadastrados com sucesso!"
  end
end
