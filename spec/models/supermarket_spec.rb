# == Schema Information
#
# Table name: supermarkets
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Supermarket, type: :model do
  describe 'Fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:prices).class_name('Price').dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
