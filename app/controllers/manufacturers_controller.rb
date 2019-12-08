class ManufacturersController < ApplicationController
  before_action :authenticate_user! #faz com que antes de rodar tudo, o usuario tenha que estar logado. Se fosse para estar logado em algumas acoes, so adicionar o only
  before_action :authorize_admin
  before_action :set_manufacturer, only: [:show, :edit, :update]

  def index
    @manufacturers = Manufacturer.all
  end

  def show ; end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    
    if @manufacturer.save
      flash[:notice] = 'Fabricante registrado com sucesso!'
      redirect_to @manufacturer
    else
      render :new #usando a view do new, mas ainda esta fazendo o create. Dessa forma, ele mantem os dados que estao no form
    end
  end

  def edit ; end

  def update  
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fabricante editado com sucesso!'
      redirect_to @manufacturer
    else
      render :edit
    end
  end

  private
  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, notice: 'Voce nao possui autorizacao para essa acao' unless current_user.admin? #redirecione para root_path A NAO SER que o usuario seja admin
  end

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end