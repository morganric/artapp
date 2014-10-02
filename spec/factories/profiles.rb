# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    display_name "MyString"
    user_id 1
    bio "MyText"
    image "MyString"
    dob "2014-10-02"
    location "MyString"
    website "MyString"
  end
end
