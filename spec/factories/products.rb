# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string
#  quantity   :float
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :product do
    name { 'Product' }
    quantity { 0.5 }
    unit { 'unit' }
  end
end
