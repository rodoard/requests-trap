FactoryGirl.define do
  factory :request do
    initialize_with do
      Request::COLUMNS.inject({}) do |result, column|
        column_s = column.to_s
        result[column_s]=column_s
        result
      end.merge({
                 "request_date" => Date.today.to_s,
                 "query_params" => {"query" => "params"},
                 "headers" => {"headers" => "headers"}
                })
    end
  end
end