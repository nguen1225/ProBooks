class HomesController < ApplicationController
  def top
    @contact = Contact.new
  end
end
