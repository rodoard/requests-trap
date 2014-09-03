class Request < ActiveRecord::Base
  validates :data, presence: true
  validates :cat, presence: true
  belongs_to :trap
end