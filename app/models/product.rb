class Product < ApplicationRecord
  has_many :discounts, dependent: :destroy

  validates :name, :code, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
