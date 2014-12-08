# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    piece_id 1
    amount 1.5
    user_id 1
    email "MyString"
  end
end
