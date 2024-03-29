# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable, :omniauthable, omniauth_providers:
      %i[github google_oauth2]

  has_many :solutions, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  after_commit :add_default_avatar, on: %i[create update]
  acts_as_voter

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    user ||= User.create(email: data['email'],
                         password: Devise.friendly_token[0, 20])
    user
  end

  def username
    email.split('@')[0]
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.png')),
      filename: 'default_profile.png',
      content_type: 'image/png'
    )
  end
end
