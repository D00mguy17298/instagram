class Post < ApplicationRecord

  include Visible
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  has_one_attached :avatar
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at", "user_id"]
  end



end