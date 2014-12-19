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
  s.description_body = ''
  s.description_style = ''
  s.description_script = ''
  s.google_maps_uri = 'http://maps.google.com/maps?hl=en&amp;q=5600+Tennyson+Parkway+Plano,+TX+75024&amp;safe=off&amp;ie=UTF8&amp;hq=&amp;hnear=5600+Tennyson+Pkwy,+Plano,+Texas+75024&amp;gl=us&amp;sqi=2&amp;z=14&amp;ll=33.070596,-96.816459'
  s.published = true

  id += 1
end
