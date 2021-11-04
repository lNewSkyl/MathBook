class Article < ApplicationRecord

  belongs_to :user
  has_one_attached :avatar
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_rich_text :body
  acts_as_votable
  has_many :solutions

  
  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :answer, presence: true
end