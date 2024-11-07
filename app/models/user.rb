
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Visible
  searchkick
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one_attached :avatar

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :name, presence: true

  validates :email, presence: true, uniqueness: true
  
  has_many :likes , dependent: :destroy
  

  def initials
    name.split.map { |part| part[0] }.join.upcase
  end

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: { user: 'user', admin: 'admin' }
      
        after_initialize :set_default_role, if: :new_record?
      
        def set_default_role
          self.role ||= :user
        end
      
        def self.ransackable_attributes(auth_object = nil)
          %w[email role created_at]
        end
      
        def self.ransackable_associations(auth_object = nil)
          ["posts"]
        end
        def search_data
          {
            name: name
          }
        end
      
        # Add search method
        def self.search_users(query)
          User.search(query, fields: [:name], match: :word_start)
        end
         
         protected
         def password_required?
          confirmed? ? super : false
        end

        


        def user_params
          params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :status)
        end
        

        


        

end
