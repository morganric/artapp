# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :piece do
    title "MyString"
    image "MyString"
    description "MyText"
    dimensions "MyText"
    views 1
    user_id 1
    price 1.5
    sold false
  end
end
