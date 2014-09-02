class Trap < ActiveRecord::Base
  validates :name, presence: true
  def self.requests_for(trap_id, type)
    []
  end
  def self.add_new_request(trap_id, request)
    true
  end

end