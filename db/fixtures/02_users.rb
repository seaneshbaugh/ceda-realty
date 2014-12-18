id = 1

User.seed do |s|
  s.id = id
  s.username = 'seshbaugh'
  s.email = 'seshbaugh@cedarealty.com'
  s.password = 'changeme'
  s.password = 'changeme'
  s.first_name = 'Sean'
  s.last_name = 'Eshbaugh'

  id += 1
end

User.seed do |s|
  s.id = id
  s.username = 'sgoff'
  s.email = 'sgoff@cedarealty.com'
  s.password = 'changeme'
  s.password = 'changeme'
  s.first_name = 'Steve'
  s.last_name = 'Goff'

  id += 1
end
