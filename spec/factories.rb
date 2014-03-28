FactoryGirl.define do
  sequence(:title) { |n| "Fake title #{n}" }
  sequence(:email) { |n| "#{Faker::Internet.email} #{n}" }

  factory :option do
    text Faker::Lorem.characters(char_count = 10)
    question
  end

  factory :option_with_question do
    text Faker::Lorem.characters(char_count = 10)
    ignore do
      options_count 1
    end
    after(:create) do |option, evaluator|
      create_list(:question, evaluatory.questions_count, option: option)
    end
  end
  
  factory :survey do
    title
  end

  factory :question do
    prompt Faker::Lorem.sentence(word_count = 5, random_words_to_add = 4)
    survey
  end

  factory :user do
    name Faker::Name.name
    email
    password '123456'
  end

  factory :response do
    user
    option_with_question
  end
end