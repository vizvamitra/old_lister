FactoryGirl.define do
  factory :list_item do
    sequence(:id) { |n| n }
    sequence(:text) { |n| "list item #{n}" }
    done false
  end

  
end