require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:menu_categories) }

  it { should have_many(:menus).through(:menu_categories) }

  it 'is valid with a name and a description' do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it 'is invalid without a name' do
    category = FactoryBot.build(:category, name: nil)

    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'is valid with a duplicate name' do
    category1 = FactoryBot.create(:category, name: 'Indonesia')
    category2 = FactoryBot.build(:category, name: 'Indonesia')

    category2.valid?
    expect(category2.errors[:name]).to include("has already been taken")
  end
end
