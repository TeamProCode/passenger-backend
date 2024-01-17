class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist 
  has_many :destinations
  has_many :photos, through: :destinations
  validates :email, presence: true
  validates :email, uniqueness: true
  # validates the presence of password when id is nil aka the account is new and does not have an id yet
  # -> lamdba syntax: creates an anonymous function that checks for existence of id; if true, password validation applied
  validates :password, presence: true
  validates :password, length: { minimum: 8 }
  # validates :password, confirmation: true
end
