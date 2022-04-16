require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:order_menus) }

  it { should have_many(:menus).through(:order_menus) }
  
  it 'is valid with data filled' do
    expect(FactoryBot.build(:order)).to be_valid
  end

  it 'is invalid without a customer name' do
    menu = FactoryBot.build(:order, customer_name: nil)

    menu.valid?
    expect(menu.errors[:customer_name]).to include("can't be blank")
  end

  it 'is invalid without a customer email' do
    menu = FactoryBot.build(:order, customer_email: nil)

    menu.valid?
    expect(menu.errors[:customer_email]).to include("can't be blank")
  end

  it 'is invalid with wrong email format' do
    menu = FactoryBot.build(:order, customer_email: "test@gigih")

    menu.valid?
    expect(menu.errors[:customer_email]).to include("invalid email format")
  end
end
