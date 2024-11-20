require 'rails_helper'

describe ContactsController, type: :controller do

  it 'Request Index and return 401 Unauthorized' do
    get :index 
    expect(response).to have_http_status(401)
  end

end