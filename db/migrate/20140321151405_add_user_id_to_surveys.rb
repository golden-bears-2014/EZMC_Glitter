class AddUserIdToSurveys < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.belongs_to :user
    end
  end
end