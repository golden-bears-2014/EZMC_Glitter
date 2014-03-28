FactoryGirl.define do
  sequence(:title) { |n| "Fake title #{n}" }
  sequence(:email) { |n| "#{Faker::Internet.email} #{n}" }

  factory :option do
    text Faker::Lorem.characters(char_count = 10)
    question
  end
 
  factory :survey do
    title

    factory :survey_with_questions do
      ignore do
        questions_count 3
      end
      after(:create) do |survey, evaluator|
        create_list(:question, evaluator.questions_count, survey: survey)
      end
      factory :question_with_response do
        after(:create) do |question, evaluator|
          create_list(:response, 2, question: question)
        end
      end
    end

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
    option
  end
end