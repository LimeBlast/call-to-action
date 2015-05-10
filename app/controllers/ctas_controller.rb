class CtasController < ApplicationController
  respond_to :html, :json

  def index
    @ctas = Cta.all
  end

  def search
    params[:story]
  end

  def new
    @cta = Cta.new
    authorize @cta, :create?

    respond_with @cta
  end

  def create
    @cta = Cta.new(cta_params)

    @cta.save
    redirect_to ctas_path
  end

  def edit
    @cta = Cta.find(params[:id])
    authorize @cta, :edit?

    respond_with @cta
  end

  def update
    @cta = Cta.find(params[:id])
    authorize @cta, :update?

    if @cta.update(cta_params)
      flash[:notice] = "updated"
      respond_with @cta, location: ctas_path, id: @cta.id
    else
      respond_with @cta
    end
  end

  def destroy
    @cta = Cta.find(params[:id])
    authorize @cta, :destroy?

    @cta.destroy

    redirect_to ctas_path
  end

  private
    def cta_params
      params
        .require(:cta)
        .permit(
          :title,
          :url,
          :always,
          :keywords
        )
    end
end