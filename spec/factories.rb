FactoryGirl.define do
  factory :list_item do
    sequence(:id) { |n| n }
    sequence(:text) { |n| "list item #{n}" }
    done false
  end

  factory :user do
    sequence(:id) { |n| n }
    sequence(:login) { |n| "User_#{n}" }
    password "password"
    password_confirmation "password"
  end
end