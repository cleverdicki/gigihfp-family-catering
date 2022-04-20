FactoryBot.define do
  factory :order do
    customer_name { "MyString" }
    customer_email { "bigdaddy@generasigigih.com" }
    total_price { 1.5 }
  end
end