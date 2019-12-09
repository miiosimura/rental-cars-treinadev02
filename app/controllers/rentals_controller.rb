class RentalsController < ApplicationController
  def index

  end

  def show
    @rental = Rental.find(params[:id])
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

  def search
    
  end
end