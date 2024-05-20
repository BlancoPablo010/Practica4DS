class VehiculoController < ApplicationController
  def index
    @vehiculos = Vehiculo.where(usuario: params[:usuario])
    render json: @vehiculos
  end

  def show
    @vehiculo = Vehiculo.find(params[:id])
    render json: @vehiculo
  end

  def create
    @vehiculo = Vehiculo.new(vehiculo_params)
    if @vehiculo.save
      render json: @vehiculo, status: :created
    else
      render json: @vehiculo.errors, status: :unprocessable_entity
    end
  end

  def update
    @vehiculo = Vehiculo.find(params[:id])
    if @vehiculo.update(vehiculo_params)
      render json: @vehiculo
    else
      render json: @vehiculo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vehiculo = Vehiculo.find(params[:id])
    if @vehiculo.destroy
      head :ok
    else
      render json: { status: 'ERROR', message: 'Vehiculo not deleted', data: @vehiculo.errors }, status: :unprocessable_entity
    end
  end

  private

  def vehiculo_params
    params.require(:vehiculo).permit(:motor, :ruedas, :carroceria, :personalizacion, :usuario, :color)
  end
end
