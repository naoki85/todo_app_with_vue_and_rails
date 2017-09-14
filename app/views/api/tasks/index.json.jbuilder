json.set! :tasks do
  json.array! @tasks do |task|
    json.extract! task, :id, :name, :is_done, :created_at, :updated_at
  end
end