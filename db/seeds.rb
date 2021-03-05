User.find_or_initialize_by(name: 'admin') do |user|
  user.password = 'password'
  user.save!
end
