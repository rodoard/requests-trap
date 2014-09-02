class Request < ActiveRecord::Base
  validates :body, presence: true
  validates :cat, presence: true
  belongs_to :trap
end