class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.create(manufacturer_params)
    redirect_to @manufacturer #passando um objeto, o rails ja reconhece que deve ser feito um show, pegando seu id
  end

  private
  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end