module V1
  # ProductsController
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_store
    before_action :set_product, only: %i[update]

    # GET /v1/products
    def index
      @products = @store.products
      render json: { products: @products }, status: :ok
    end

    # GET /v1/products/:id
    def show
      @product = @store.products.find_by(id: params[:id])
      if @product
        render :show, status: :ok
      else
        head :not_found
      end
    end

    # POST /v1/products/
    def create
      @product = @store.products.new(product_params)
      if @product.valid?
        @product.save
        render :show, status: :created
      else
        render json: { errors: @product.errors.messages }, status: :bad_request
      end
    end

    # PUT /v1/products/:id
    def update
      if @product.update(product_params)
        render :show, status: :ok
      else
        render json: { errors: @product.errors.messages }, status: :bad_request
      end
    end

    # DELETE /v1/products/:id
    def destroy
      @product = @store.products.find_by(id: params[:id])
      if @product
        @product.destroy
        head :no_content
      else
        head :not_found
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def set_store
      @store = @current_user.store
    end

    def set_product
      @product = @store.products.find_by(id: params[:id])
      head :not_found unless @product
    end
  end
end
