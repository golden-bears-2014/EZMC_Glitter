require 'faker'


user = User.new(name: Faker::Name.name, email: Faker::Internet.email)
user.password = "password"
user.save!

survey_names = ["What do you like most?", "All about Glitter", "Vacation spots", "Age and country survey"]

survey_names.each do |survey|
   s = Survey.create(title: survey)
   4.times do
    q = Question.create(prompt: Faker::Company.catch_phrase)
    4.times do
      o = Option.create(text: Faker::Company.name)
      4.times do
        user.responses.create(option_id: o.id)
      end
      q.options << o
    end
    s.questions << q
  end
end





