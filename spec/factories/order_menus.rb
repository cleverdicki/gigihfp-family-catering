FactoryBot.define do
  factory :order_menu do
    order { nil }
    menu { nil }
    quantity { 1 }
    total_price { 1.5 }
  end
end
