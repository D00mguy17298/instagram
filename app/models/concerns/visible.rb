module Visible
  extend ActiveSupport::Concern

  VALID_USER_STATUSES = ['public', 'private']

  VALID_POST_STATUSES = ['public', 'archived']

  

  included do
    validates :status, inclusion: { in:  VALID_POST_STATUSES + VALID_USER_STATUSES }
  end

  def archived?
    status == 'archived'
  end
  
  def private?
    status == 'private'
  end

  
end