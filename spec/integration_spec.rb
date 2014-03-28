require 'spec_helper'

describe "**** Cabybara: Form Pages", :type => :feature, :js => true do
  describe "Sign up" do
    before :each do
      User.destroy_all
      # User.create(:name => 'capybara', :email => 'capybara@capybara.com',  :password_hash => 'capybara123')
    end

    it "Logs in after signup form completed and go to Surveys page" do
      visit '/'
      within("#create_account") do
        fill_in 'name', :with => 'capybara'
        fill_in 'email', :with  => 'capybara@capybara.com'
        fill_in 'password', :with => 'capybara123'
      end
      click_on 'Go'
      expect(page).to have_content 'Click a survey'
    end
  end

  describe "Log in" do
    before :each do
      User.destroy_all
      User.create(:name => 'capybara', :email => 'capybara@capybara.com',  :password_hash => 'capybara123')
    end

    it "Creates user and goes to Surveys page" do
      visit '/'
      within("#sign_up") do
        fill_in 'email', :with  => 'capybara@capybara.com'
        fill_in 'password', :with => 'capybara123'
      end
      click_on 'Login'
      expect(page).to have_content 'Click a survey'
    end
  end


  describe "Create a survey", :type => :feature, :js => true do
    it "Creates a survey" do
      visit '/surveys/new'
      within("#survey") do
        fill_in 'title', :with => 'MySurveyTitle'
      end
      click_on 'Create Survey'
      expect(page).to have_content 'Click a survey'
    end
  end

  describe "Create a survey - add question", :type => :feature, :js => true do
    it "Creates a survey" do
      visit '/surveys/new'
      within("#survey") do
        fill_in 'title', :with => 'MySurveyTitle2'
      end
      click_on 'Add a new question!'
      expect(page).to have_content 'Prompt'
    end
  end

  # TODO - this test not working
  describe "Create a survey - add question - add question content", :type => :feature, :js => true do
    it "Adds a question" do
      # within("#question_template") do
        fill_in('prompt', :with => 'Question 111')
        fill_in('optiona', :with => 'aaaaa')
        fill_in('optionb', :with => 'bbbbb')
        fill_in('optionc', :with => 'ccccc')
      # end
      click_on 'Add a new question!'
      expect(page).to have_content 'Prompt'
    end
  end

  # TODO - this test not working
  # describe "Log out" do
  #   it "Logs you out and returns to login page" do
  #     visit '/surveys'
  #     click_on 'Logout'
  #     expect(page).to have_content 'Sign Up'
  #   end
  # end

end

