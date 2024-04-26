# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  def name_or_email
    comment.user_id == current_user.id ? current_user.email : current_user.name 
  end
end
