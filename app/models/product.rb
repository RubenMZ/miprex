# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product <  ApplicationRecord


  validates :name, presence: true


  validates :unit, presence: true


end

