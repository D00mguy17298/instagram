class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at", "user_id"]
  end
end