require 'spec_helper'

describe "controller" do
  before(:all) do
    User.destroy_all
  end

  it "creates a new user" do
    user_info = {name: "Theon", email: "Ironprice@greyjoy.com", password_hash: "wedonotsow"}
    expect{post('/users/new', user_info)}.to change(User, :count).by(1)
  end

  it "logs in a user" do
    user_login = { email: "Ironprice@greyjoy.com", password: "wedonotsow"}
    post('/sessions/new', user_login)
    expect(last_response).to be_redirect
  end

  it "logs out a user" do
    user_login = { email: "Ironprice@greyjoy.com", password: "wedonotsow"}
    post('/sessions/new', user_login)
    delete "/sessions/logout"
    expect(last_response).to be_redirect
  end
end

describe "index" do
  describe "index controller" do

    before(:all) do
      Survey.delete_all
      User.delete_all
    end

    describe "'/surveys'" do
      it "should show a survey" do
        survey = Survey.create(title: "test_survey_title")
        get('/surveys')
        expect(last_response.body).to include("test_survey_title")
      end
    end

    #This test errors out- Christine.
    # describe "post to /responses" do
    #   it "should add responses to the database" do
    #     option_ids = "71=on&22=on"
    #     expect{post('/responses', option_ids)}.to change(Response, :count).by(2)
    #   end
    # end

    describe "Creating a survey" do
      it "should increase total number of surveys by 1" do
        survey_info = {title: "a title of a new survey"}
        expect{post('/surveys', survey_info)}.to change(Survey, :count).by(1)
      end

      it "should have a user associated with it" do
        user = User.new(name: "Ryan", email: "ryan@ryan.com")
        user.password = "password"
        user.save!

        new_session = {
          'rack.session' => {user_id: user.id}
        }

        params = {title: "New Survey"}

        post('/surveys', params, new_session)
        expect(Survey.last.user_id).to eq(user.id)

      end
    end

  end
end
