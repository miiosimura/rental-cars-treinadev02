class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @categories = Category.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    
    if @car_model.save
      flash[:notice] = 'Modelo de carro registrado com sucesso!'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @categories = Category.all
      render :new
    end
  end

  def edit
    @car_model = CarModel.find(params[:id])
    @manufacturers = Manufacturer.all
    @categories = Category.all
  end

  def update
    @car_model = CarModel.find(params[:id])

    if @car_model.update(car_model_params)
      flash[:notice] = 'Modelo editado com sucesso!'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @categories = Category.all
      render :edit
    end
  end

  private
  def car_model_params
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type, :category_id, :manufacturer_id)
  end
end