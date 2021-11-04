class Comment < ApplicationRecord

  belongs_to :article
  validates :content, presence: true, length: { minimum: 1 }
end