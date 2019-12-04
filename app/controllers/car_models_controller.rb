class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @categories = Category.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    
    if @car_model.save
      flash[:notice] = 'Modelo registrado com sucesso!'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @categories = Category.all
      flash[:alert] = 'Erro'
      render :new
    end
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  private
    def car_model_params
      params.require(:car_model).permit(:name, :year, :motorization, :fuel_type, :category_id, :manufacturer_id)
    end
end