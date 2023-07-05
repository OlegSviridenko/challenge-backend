class Discount < ApplicationRecord
  COUNT_VARIABLE = 'COUNT'.freeze
  validates :condition, presence: true, format: {
    with: /#{COUNT_VARIABLE}/, message: "Bad formula, use #{COUNT_VARIABLE} as a count of products in formula"
  }

  belongs_to :product
end

# (30 if COUNT >= 150) || ((COUNT / 10) * 2)
