# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    calculator.call(products_lists)

    if calculator.errors.any?
      render_bad_request(error_message: calculator.errors.join('; '))
    else
      render json: json_response(calculator.value)
    end
  end

  private

  def products_lists
    params.require(:items)
  end

  def json_response(value)
    {
      items: products_lists,
      total: value
    }
  end

  def calculator
    @calculator ||= TotalPriceCalculator.new
  end
end
