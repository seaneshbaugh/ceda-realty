id = 1

Office.seed do |s|
  s.id = id
  s.picture_id = nil
  s.manager_id = User.where(username: 'sgoff').first.id
  s.name = 'CEDA Realty'
  s.street_address_1 = '5600 Tennyson Parkway'
  s.street_address_2 = 'Suite #135'
  s.city = 'Plano'
  s.state = 'Texas'
  s.zipcode = '75024'
  s.phone_number = '972-378-9200'
  s.fax_number = '972-378-9209'

  id += 1
end
