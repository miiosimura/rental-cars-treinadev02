class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :start]

  def index
    @rentals = Rental.all
  end

  def show
    #TODO pesquisar diferenca de include e join
    #@cars = Car.joins(car_model: :category).where(car_models: {categories: @rental.category})    #dessa forma, quero procurar dentro de car o car_model, e dentro do car_model quero ver o category
    @cars = @rental.category.cars #essa linha é a mesma coisa que a de cima, pode ser feito assim gracas ao through dentro de category
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @categories = Category.all
  end

  def create
    @rental = Rental.new(params.require(:rental).permit(:start_date, :end_date, :client_id, :category_id))

    if @rental.save
      redirect_to @rental, notice: 'Locação agendada com sucesso!'
    else
      @clients = Client.all
      @categories = Category.all
      render :new
    end
  end

  def edit
    @clients = Client.all
    @categories = Category.all
  end

  def update
    if @rental.update(params.require(:rental).permit(:start_date, :end_date, :client_id, :category_id))
      redirect_to @rental, notice: 'Locação editada con sucesso!'
    else
      @clients = Client.all
      @categories = Category.all
      render :edit
    end
  end

  def search
    #if params[:q].length > 3
    @rentals = Rental.where('reservation_code like ?', "%#{params[:q]}%")
    
    # TODO criar a view de search
    render :search
  end

  def start
    @rental.in_progress! #mesma coisa que fazer @rental.update(status: :in_progress)
    @car = Car.find(params[:rental][:car_id])
    @car.unavailable!
    @rental.create_car_rental(car: @car, price: @car.price) #dessa forma, ele cria um car_rental com o tipo de carro amarrado. Equivale a Rental.create(rental: @rental, car: @car)
    flash[:notice] = 'Locação iniciada com sucesso!'
    redirect_to @rental
  end

  private
  def set_rental
    @rental = Rental.find(params[:id])
  end
end