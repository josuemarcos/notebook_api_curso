class PhonesController < ApplicationController
  before_action :set_phones

  def show
    render json: @phones
  end

  private
   
    def set_phones
      #if params[:contact_id]
        @phones = Contact.find(params[:contact_id]).phones
        #return @phones
      #end

      #@phones = phones.where( id: params[:id])
    end
end
