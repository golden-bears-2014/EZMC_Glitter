require 'spec_helper'

describe 'model' do

  describe Survey do
      it {should belong_to(:user)}
      it {should have_many(:questions)}
      it {should have_many(:questions)}
      it {should allow_value('My Survey').for(:title)}
  end




end