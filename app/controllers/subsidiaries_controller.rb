class SubsidiariesController < ApplicationController
  def index
     #metodo index vazio, ele faz automaticamente render :index
     @subsidiaries = Subsidiary.all   
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end
end