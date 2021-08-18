# == Schema Information
#
# Table name: supermarkets
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :supermarket do
    name { 'Supermarket' }
  end
end
