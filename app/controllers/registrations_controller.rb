class RegistrationsController < ApplicationController
  before_action :clean_cpf, only: %i[create]
  before_action :strip_name, only: %i[create]
  skip_before_action :verify_current_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Usuário cadastrado com sucesso!"
    else
      flash.now[:alert] = "Ops, aconteceu algo errado!"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :cpf, :password, :password_confirmation, :is_client)
  end

  def clean_cpf
    params[:user][:cpf] = params[:user][:cpf].gsub(/\D/, "")
  end

  def strip_name
    params[:user][:name] = params[:user][:name].strip.squish
  end
end