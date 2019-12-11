class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :start]

  def index
    @rentals = Rental.all
  end

  def show
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
    
  end

  def start
    
  end

  private
  def set_rental
    @rental = Rental.find(params[:id])
  end
end