class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    products = Product.page(params[:page]).per(params[:per_page])

    render json: {
        data: products,
        meta: {
            count: products.count,
            total: products.total_pages
        }
    }, status: :ok
  end

  def create
    product = Product.create!(create_params)

    render json: {
        data: product
    }, status: :created

  rescue StandardError => e
    render json: {
        message: e.to_s
    }, status: :bad_request
  end

  def show
    product = Product.find(params[:id])

    render :json => product, status: :ok

    rescue ActiveRecord::RecordNotFound => e
        render json: {
            message: e.to_s
        }, status: :not_found
  end

  def update
    product = Product.find(params[:id])

    product.update(update_params)

    render :json => product, status: :ok

    rescue ActiveRecord::RecordNotFound => e
        render json: {
            message: e
        }, status: :not_found
  end

  def destroy
    product = Product.find(params[:id])

    product.destroy

    render :json => {}, status: :ok

    rescue ActiveRecord::RecordNotFound => e
        render json: {
            message: e
        }, status: :not_found
  end

  private

  def create_params
    params.permit(:name, :price, :category)
  end

  def update_params
    params.permit(:id, :name, :price, :category)
  end
end
