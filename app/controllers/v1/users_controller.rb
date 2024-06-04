module V1
  # UsersController
  class UsersController < ApplicationController
    # POST /v1/users
    def create
      @user = Owner.new(user_params)
      if @user.valid?
        @user.save
        @token = @user.tokens.create
        # render json: @user, status: :created
        render :show, status: :created
      else
        render json: { errors: @user.errors.messages }, status: :bad_request
      end
    end

    # POST /v1/users/login
    def login
      @user = User.find_by(email: login_params[:email])
      if @user.present? && @user.authenticate(login_params[:password])
        @token = @user.tokens.create
        render :show
      else
        render json: { errors: I18n.t('user.bad_credentials') }, status: :bad_request
      end
    end

    # POST /v1/users/employee
    def create_employee
      @employee = Employee.new(user_params)
      if @employee.valid?
        @employee.save
        @token = @employee.tokens.create
        render :show, status: :created
      else
        render json: { errors: @employee.errors.messages }, status: :bad_request
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end

    def user_params
      params.permit(:email, :password, :age, store_attributes: %i[name])
    end
  end
end
