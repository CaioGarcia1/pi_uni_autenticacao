class SessionsController < ApplicationController
  skip_before_action :verify_current_user, only: [:new, :create]
  before_action :find_user_by_cpf, only: %i[ create ]

  def new
  end

  def create
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      ahoy.authenticate(@user)
      redirect_to root_path, notice: "Login efetuado com sucesso!"
    else
      flash.now[:alert] = "Usuário ou senha inválidos"
      render action: :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete("ahoy_visit")
    redirect_to sign_in_path
  end

  private

  def find_user_by_cpf
    @cpf_numbers = params[:cpf].gsub(/\D/, "")
    @user = User.find_by(cpf: @cpf_numbers)
  end
end