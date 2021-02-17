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
class Product <  ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true
  validates :unit, presence: true

  has_many :prices, inverse_of: :product, dependent: :destroy

  def min_price
    prices.order('value ASC').first
  end

  def ordered_last_prices
    last_prices.sort_by{|x| x[:value] }[0..2]
  end

  def last_prices
    prices.order('created_at ASC').group_by(&:supermarket_id).values.map(&:last)
  end
end

