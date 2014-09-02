class Trap < ActiveRecord::Base
  validates :name, presence: true
  has_many :requests
  def self.requests(trap_id)
    trap = find_by_name trap_id
    trap.try(:requests) || []
  end
  def self.requests_for(trap_id, type)
    trap = find_by_name trap_id
    trap.requests.select {|request| request.cat == type}  if trap
  end
  def self.add_new_request(trap_id, request, type="get")
    trap = find_or_create_by(name:trap_id)
    trap.requests.create! body: request, cat: type
  end
end