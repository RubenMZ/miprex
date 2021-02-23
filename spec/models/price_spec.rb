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
require 'rails_helper'

RSpec.describe Price, type: :model do
  describe 'Fields' do
    it { is_expected.to have_db_column(:value).of_type(:float) }
    it { is_expected.to have_db_column(:product_id).of_type(:integer) }
    it { is_expected.to have_db_column(:supermarket_id).of_type(:integer) }
  end

  describe 'Relationships' do
    it { is_expected.to belong_to(:product).class_name('Product') }
    it { is_expected.to belong_to(:supermarket).class_name('Supermarket') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:value) }
  end
end
