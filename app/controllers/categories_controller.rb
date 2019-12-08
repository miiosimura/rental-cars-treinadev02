class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_category, only: [:show, :edit, :update]
  
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = 'Categoria registrada com sucesso!'
      redirect_to @category
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Categoria editada com sucesso!'
      redirect_to @category
    else
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, notice: 'Voce nao possui autorizacao para essa acao' unless current_user.admin?
  end
end