class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  searchkick
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one_attached :avatar

  validates :name, presence: true
  def initials
    name.split.map { |part| part[0] }.join.upcase
  end

  has_many :posts, dependent: :destroy

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



        

        


        

end
