class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :likes, :dependent => :destroy
  has_many :liked_posts, :through => :likes, :source => :post
  has_many :favorites, :dependent => :destroy
  has_many :favorite_posts, :through => :favorites, :source => :post

  def display_name
    self.email.split("@").first
  end

  def is_admin?
    role == "admin"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
