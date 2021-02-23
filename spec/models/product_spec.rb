# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  image_url  :string
#  name       :string
#  quantity   :float
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Product, type: :model do
  describe 'Fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:quantity).of_type(:float) }
    it { is_expected.to have_db_column(:unit).of_type(:string) }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:prices).class_name('Price').dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:unit) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
