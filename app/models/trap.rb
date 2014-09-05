class Trap < ActiveRecord::Base
  validates :name, presence: true
  has_many :requests
  def self.requests(trap_id)
    trap = find_by_name trap_id
    trap.try(:requests) || []
  end
  def self.requests_for(trap_id, type)
    trap = find_by_name trap_id
    downcased_type = type
    if trap
      trap.requests.select {|request| request.cat == downcased_type}
    else
      []
    end
  end
  def self.find_or_create_trap(trap_id)
    find_or_create_by!(name:trap_id)
  end
  def self.request(trap_id, request_id)
    trap = find_by_name trap_id
    trap.requests.find request_id rescue nil if trap
  end
  def self.add_new_request(trap_id, request, response, type="get")
    trap = find_or_create_trap(trap_id)
    trap.requests.create! data: { body: request, response: response }, cat: type.downcase
  end
end