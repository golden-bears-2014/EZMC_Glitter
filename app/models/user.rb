class User < ActiveRecord::Base
  # Remember to create a migration!
  include BCrypt
  validates :email, uniqueness: true
  validates :name, :email, :password_hash, presence: true
  has_many :surveys
  has_many :responses
  has_many :options, through: :responses

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.create(params)
    user = User.new(params)
    user.password = params[:password_hash]
    user.save!
    return user
  end

  def login(input_password)
    self.password == input_password
  end

  def update_password(params)
    if self.password == params[:old] && params[:new] == params[:repeat_new]
      self.update_attributes(password_hash: Password.create(params[:new]))
    end
  end

end
