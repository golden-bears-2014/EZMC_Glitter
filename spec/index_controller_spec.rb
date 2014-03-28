require 'spec_helper'

describe "User login" do
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

describe "IndexController" do
   before(:all) do
    Survey.delete_all
    User.delete_all
  end

  describe "get '/surveys'" do
    it "shows a survey" do
      survey = Survey.create(title: "test_survey_title")
      get('/surveys')
      expect(last_response.body).to include("test_survey_title")
    end
  end

  #This test errors out- Christine.
  # describe "post to /responses" do
  #   it "should add responses to the database" do

  describe "post to /responses" do
    let!(:question){ FactoryGirl.create(:question) }
    let!(:response){ FactoryGirl.create(:response) }

    it 'adds a new response to the database' do
      expect{ post('/responses',
                   user_id: response.user_id,
                   option_id: response.option_id,
                   question: question) }.to change(Response, :count).by(1)
    end
  end
  
  describe "post to /surveys" do
    it "increases total number of surveys by 1" do
      survey_info = {title: "a title of a new survey"}
      expect{post('/surveys', survey_info)}.to change(Survey, :count).by(1)
    end

    it "has a user associated with it" do
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
