class CarModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_car_model, only: [:show, :edit, :update]

  def index
    @car_models = CarModel.all
  end

  def show
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
      render :new
    end
  end

  def edit
    @manufacturers = Manufacturer.all
    @categories = Category.all
  end

  def update
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

  def set_car_model
    @car_model = CarModel.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, notice: 'Voce nao possui autorizacao para essa acao' unless current_user.admin?
  end
end