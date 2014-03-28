require 'spec_helper'

describe 'model' do

  describe Survey do
      it {should belong_to(:user)}
      it {should have_many(:questions)}
      it {should have_many(:questions)}
      it {should allow_value('My Survey').for(:title)}
  end

  describe User do
    it {should have_many(:surveys)}
    it {should have_many(:responses)}
    it {should have_many(:options).through(:responses)}
    it {should_not allow_value("").for(:email)}
    it {should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password_hash)}
  end

  describe Response do
    it {should belong_to(:user)}
    it {should belong_to(:option)}
  end

  describe Option do
    it {should have_many(:responses)}
    it {should have_many(:users).through(:responses)}
    it {should allow_value("This is an option").for(:text)}
  end


end