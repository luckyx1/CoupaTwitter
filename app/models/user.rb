class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  has_many :tweets

  #make sure that password is correct
  validates_confirmation_of :password
  #make sure these values are present
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :name, :on => :create

  #currently, one user <=>one email
  validates_uniqueness_of :email

   #functions to call before instaniate
  before_create :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  #encrypt password logic
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
