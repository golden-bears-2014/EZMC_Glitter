require 'spec_helper'

describe 'Profile' do
  it "shows the user profile page" do
    User.destroy_all
    user = User.new(name: "Ryan", email: "ryan@ryan.com")
    user.password = "password"
    user.save!
    user_login = {email: user.email, password: "password"}
    post('/sessions/new', user_login)
    get "/users/#{user.id}"
    expect(last_response.body).to include user.name
  end

end


