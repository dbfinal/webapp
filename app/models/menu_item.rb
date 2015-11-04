class MenuItem < ActiveRecord::Base
  attr_accessor :id, :name, :picture_url, :price, :created_at, :updated_at
  belongs_to :restaurant
  belongs_to :category
  has_many :user_pictures #need to change relation in ERD
  has_many :user_scores
  has_one :menu_item_score #need to change relation in ERD
end
