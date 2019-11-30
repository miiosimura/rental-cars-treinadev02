class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    redirect_to @category
  end

  private
  def category_params
    params.require(:category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end