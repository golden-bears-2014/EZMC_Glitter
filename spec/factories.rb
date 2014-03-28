FactoryGirl.define do
  sequence(:title) { |n| "Fake title #{n}" }
  
  factory :survey do
    title
  end

  factory :question do
    prompt Faker::Lorem.sentence(word_count = 5, random_words_to_add = 4)
    survey
  end

  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password '123456'
  end

  factory :option do
    text Faker::Lorem.characters(char_count = 10)
    question
  end

  factory :response do
    user
    option
  end
end