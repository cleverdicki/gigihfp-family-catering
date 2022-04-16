require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'is valid with a name and a description' do
    expect(FactoryBot.build(:menu)).to be_valid
  end

  it 'is invalid without a name' do
    menu = FactoryBot.build(:menu, name: nil)

    menu.valid?
    expect(menu.errors[:name]).to include("can't be blank")
  end

  it 'is valid with a duplicate name' do
    menu1 = FactoryBot.create(:menu, name: 'Lumpia')
    menu2 = FactoryBot.build(:menu, name: 'Lumpia')

    menu2.valid?
    expect(menu2.errors[:name]).to include("has already been taken")
  end

  it 'is invalid with non numeric values for Price field' do
    menu = FactoryBot.build(:menu, price: 'abc')

    menu.valid?
    expect(menu.errors[:price]).to include("is not a number")
  end

  it 'is invalid if Price less than 0.01' do
    menu = FactoryBot.build(:menu, price: 0.0)

    menu.valid?
    expect(menu.errors[:price]).to include("must be greater than 0.01")
  end

  it 'is invalid if Description more than 150 characters' do
    menu = FactoryBot.build(:menu, description: Faker::Lorem.characters(number: 151))

    menu.valid?
    expect(menu.errors[:description]).to include("is too long (maximum is 150 characters)")
  end
end
