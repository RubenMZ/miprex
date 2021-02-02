# == Schema Information
#
# Table name: prices
#
#  id             :bigint           not null, primary key
#  value          :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :bigint           not null
#  supermarket_id :bigint           not null
#
# Indexes
#
#  index_prices_on_product_id      (product_id)
#  index_prices_on_supermarket_id  (supermarket_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (supermarket_id => supermarkets.id)
#
FactoryBot.define do
  factory :price do
    product { nil }
    supermarket { nil }
    value { 1.5 }
  end
end
