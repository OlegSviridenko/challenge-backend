# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    render json: Product.all, except: %i[created_at updated_at]
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: { message: success_message }
    else
      render_bad_request
    end
  end

  private

  # Only allow price parameter
  def product_params
    params.require(:product).permit(:price)
  end

  def success_message
    'Price updated successfully'
  end

  # we can avoid using databases and import a Json file with a data structure, but since this is the merchandise of the
  # company, then for the future it is better to allow normal scaling and use the database for this
end
