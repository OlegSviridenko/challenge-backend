require 'rails_helper'

# Really have no time to cover all cases and split to unit

describe ProductsController, type: :request do
  describe '#create' do
    let!(:discount1) { create(:discount, condition:, product: product1) }
    let!(:discount2) { create(:discount, condition:, product: product2) }
    let(:product1) { create(:product, price: 3.0, code: 'A') }
    let(:product2) { create(:product, price: 5.0, code: 'B') }
    let(:price) { 10.0 }
    let(:condition) { "#{percentage} if COUNT >= 3" }
    let(:percentage) { 30 }

    let(:count1) { 1 }
    let(:count2) { 4 }

    let(:items_row) { "#{count1} #{product1.code}, #{count2} #{product2.code}" }
    let(:params) { { items: items_row } }

    let(:valid_response) do
      {
        'items' => items_row,
        'total' => ((count1 * product1.price) + (count2 * product2.price * (1 - percentage / 100.0))).round(2)
      }
    end

    it 'returns list of products with total price' do
      post order_path, params: params

      expect(JSON.parse(response.body)).to eq valid_response
    end

    context 'with invalid itesm list' do
      let(:items_row) { 'INVALID' }

      it 'return 422 error' do
        post order_path, params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['message']).to eq 'Bad Request'
      end
    end

    context 'with incorrect discount formula' do
      before { discount2.update(condition: 'Some Unsafe Staff or Wrong Formula with COUNT') }

      it 'returns bad formula error' do
        post order_path, params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['message']).not_to eq 'Bad Request'
      end
    end
  end
end
