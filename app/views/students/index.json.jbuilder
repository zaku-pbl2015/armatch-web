json.array!(@students) do |student|
  json.extract! student, :id, :name, :email, :password, :skill, :apeal
  json.url student_url(student, format: :json)
end
