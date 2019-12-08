class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_car, only: [:show, :edit, :update]
  
  def index
    @cars = Car.all
  end

  def show
  end

  def new
    @car = Car.new
    @subsidiaries = Subsidiary.all
    @car_models = CarModel.all
  end

  def create
    @car = Car.new(car_params)
    
    if @car.save
      flash[:notice] = 'Carro registrado com sucesso!'
      redirect_to @car
    else
      @subsidiaries = Subsidiary.all
      @car_models = CarModel.all
      render :new
    end
  end

  def edit
    @subsidiaries = Subsidiary.all
    @car_models = CarModel.all
  end

  def update
    if @car.update(car_params)
      flash[:notice] = 'Carro editado com sucesso!'
      redirect_to @car
    else
      @subsidiaries = Subsidiary.all
      @car_models = CarModel.all
      render :edit
    end
  end

  private
  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage, :subsidiary_id, :car_model_id)
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, notice: 'Voce nao possui autorizacao para essa acao' unless current_user.admin?
  end
end