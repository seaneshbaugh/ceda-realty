id = 1

Role.seed do |s|
  s.id = id
  s.name = 'user'

  id += 1
end

Role.seed do |s|
  s.id = id
  s.name = 'agent'

  id += 1
end

Role.seed do |s|
  s.id = id
  s.name = 'admin'

  id += 1
end

Role.seed do |s|
  s.id = id
  s.name = 'owner'

  id += 1
end

Role.seed do |s|
  s.id = id
  s.name = 'sysadmin'

  id += 1
end
