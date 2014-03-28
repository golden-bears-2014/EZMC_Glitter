class Survey < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  has_many :questions
  belongs_to :user
end
