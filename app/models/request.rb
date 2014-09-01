class Request < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :trap
end