class Request < ActiveRecord::Base
  validates :data, presence: true
  validates :cat, presence: true
  belongs_to :trap
  COLUMNS_REQUIRED = [:request_date, :remote_ip, :request_method,
              :scheme, :headers]
  COLUMNS_NOT_REQUIRED = [:query_string, :query_params, :cookies]
  COLUMNS =  [:request_date, :remote_ip, :request_method,
              :scheme, :query_string, :query_params, :cookies, :headers]
  validates *COLUMNS_REQUIRED, presence:true
  attr_accessor *COLUMNS
  COLUMNS.each do |name|
    define_method(name) do
      if data
        if  data["body"]
          data["body"][name.to_s]
        end
      end
    end
  end
  def response
    JSON.parse data["response"]
  end
  def to_value
    COLUMNS.inject({}) do |result, column|
      result[column.to_s] = self.send column
      result
    end
  end
end