FactoryBot.define do 
  factory :task do
    association :author, factory: :manager
    association :assignee, factory: :manager
    description
    state
    expired_at
  end
end
