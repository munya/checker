json.array!(@operations) do |operation|
  json.extract! operation, :id, :function_name
  json.url operation_url(operation, format: :json)
end
