# == Schema Information
#
# Table name: supermarkets
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Supermarket < ApplicationRecord
  validates :name, presence: true
end
