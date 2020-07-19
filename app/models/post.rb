class Post < ApplicationRecord
  validates_presence_of :content
  belongs_to :user
  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user
  has_many :favorites, :dependent => :destroy
  has_many :favorite_posts, :through => :favorites, :source => :user
  belongs_to :category, :optional => true

  def find_like(user)
    self.likes.where( :user_id => user.id ).first
  end

  def find_favorite(user)
    self.favorites.where( :user_id => user.id ).first
  end
end
