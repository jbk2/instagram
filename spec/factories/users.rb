FactoryGirl.define do
  factory :user do
    email 'james@bibble.com'
    password '12345678'
    password_confirmation '12345678'
    id '1'
  end
end
