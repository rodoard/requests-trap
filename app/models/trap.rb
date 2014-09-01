class Trap < ActiveRecord::Base
  validates :name, presence: true
end