FactoryGirl.define do
  sequence :name do |n|
    "trap-#{n}"
  end
  factory :trap do
    name
  end
end