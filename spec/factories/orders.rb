FactoryBot.define do
  factory :order do
    customer_name { "MyString" }
    customer_email { "MyString" }
    total_price { 1.5 }
    status { "MyString" }
  end
end
