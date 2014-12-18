id = 1

Profile.seed do |s|
  s.id = id
  s.user_id = User.where(username: 'seshbaugh').first.id
  s.picture_id = nil
  s.office_id = nil
  s.slug = 'sean-eshbaugh'
  s.display_name = 'Sean Eshbaugh'
  s.title = 'Programmer'
  s.display_email_address = ''
  s.display_phone_number = ''
  s.website_uri = ''
  s.facebook_uri = ''
  s.twitter_username = ''
  s.linked_in_uri = ''
  s.active_rain_uri = ''
  s.youtube_uri = ''
  s.instagram_uri = ''
  s.bio_body = ''
  s.bio_style = ''
  s.bio_script = ''
  s.license_number = ''
  s.years_of_experience = 0
  s.joined_at = Date.new(2011, 3, 28)
  s.published = false

  id += 1
end

Profile.seed do |s|
  s.id = id
  s.user_id = User.where(username: 'sgoff').first.id
  s.picture_id = nil
  s.office_id = nil
  s.slug = 'steve-goff'
  s.display_name = 'Steve Goff'
  s.title = 'Broker Owner'
  s.display_email_address = 'sgoff@cedarealty.com'
  s.display_phone_number = '972-824-5312'
  s.website_uri = 'http://www.cedarealty.com/'
  s.facebook_uri = 'http://www.facebook.com/sbgoff'
  s.twitter_username = 'goffics'
  s.linked_in_uri = ''
  s.active_rain_uri = ''
  s.youtube_uri = ''
  s.instagram_uri = ''
  s.bio_body = <<-eos
<p>Steve Goff has been a licensed REALTOR&reg;, Broker, Manager and instructor for more than 35 years. A nationally featured real estate speaker, Steve has trained real estate agents and Broker/Managers from coast to coast and has given real estate careers to thousands of successful real estate agents.</p>
<p>Steve is the originator of the advanced training system, Master the KEYS to Success, entrepreneurial course, Imagine, and the CREE certification (Certified Real Estate Entrepreneur). Steve is the founder, President and CEO of CEDA Realty.</p>
<p>He and his wife, Nanette, are residents of Collin County, Texas, and are native Texans with 3 sons and 9 grandchildren.</p>
eos
  s.bio_style = ''
  s.bio_script = ''
  s.license_number = ''
  s.years_of_experience = 0
  s.joined_at = Date.new(2011, 3, 28)
  s.published = false

  id += 1
end
