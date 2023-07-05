require 'rails_helper'

describe ProductsController, type: :request do
  let!(:product1) { create(:product, price:) }
  let!(:product2) { create(:product) }
  let(:price) { rand(1.0..10.0) }

  describe '#index' do
    it 'returns list of products' do
      get products_path

      expect(response.body).to eq [product1, product2].as_json(except: %i[created_at updated_at]).to_json
    end
  end

  describe '#update' do
    let(:new_price) { rand(10.1..20.0) }
    it 'updates product' do
      patch product_path(id: product1.id), params: { product: { price: new_price } }

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['message']).to eq 'Price updated successfully'
    end

    it 'raise error when price value is invalid' do
      patch product_path(id: product1.id), params: { product: { price: 'not a number' } }

      expect(response.status).to eq 422
      expect(JSON.parse(response.body)['message']).to eq 'Bad Request'
    end
  end
end
