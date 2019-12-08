class SubsidiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_subsidiary, only: [:show, :edit, :update]

  def index
    #metodo index vazio, ele faz automaticamente render :index
    @subsidiaries = Subsidiary.all   
  end

  def show
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    
    if @subsidiary.save
      flash[:notice] = 'Filial registrada com sucesso!'
      redirect_to @subsidiary
    else
      render :new
    end
    
  end

  def edit
  end

  def update
    if @subsidiary.update(subsidiary_params)
      flash[:notice] = 'Filial editada com sucesso!'
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def destroy
    @subsidiary.destroy

    redirect_to subsidiaries_path
  end

  private
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def authorize_admin
    redirect_to root_path, notice: 'Voce nao possui autorizacao para essa acao' unless current_user.admin?
  end

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end
end