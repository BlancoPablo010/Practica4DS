class UsuarioController < ApplicationController
  def index
    @usuarios = Usuario.all
    render json: @usuarios
  end

  def show
    @usuario = Usuario.find(params[:id])
    render json: @usuario
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      render json: @usuario, status: :created
    else
      render json: @usuario.errors, status: :unprocessable_entity
    end
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(usuario_params)
      render json: @usuario
    else
      render json: @usuario.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
  end

  private

  def usuario_params
    params.require(:usuario).permit(:nombre, :write)
  end
end
