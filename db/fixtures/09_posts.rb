id = 1

Post.seed do |s|
  s.id = id
  s.user_id = User.where(username: 'sgoff').first.id
  s.title = 'The CEDA Revolution has begun'
  s.slug = 'the-ceda-revolution-has-begun'
  s.body = <<-eos
<p>The time has come for a revolution in Real Estate marketing services and communication tools. Old methods and antique communication no longer fit the needs and culture of today's Buyer and Seller. The CEDA Revolution is all about reinventing the real estate experience to meet current Homeowner and Home Buyer needs.</p>
<p>For example, Home Buyers want more information and instant data when they call a for sale sign. Instead requiring interest buyers to getting out of their car to pick up a faded flyer which gives very little informaion, the CEDA experience allows the buyer to receive data, photos, video links and financing information on their Mobile Phone, simply by calling the number on the sign or scanning the QR code on the sign.</p>
<p>Sellers deserve more help in pre-marketing. CEDA Realty offers (at no initial cost and no risk to the Seller) services including Pre-Listing Home Inspection (to avoid deal-killers during the transaction), Pre-Listing Staging Consultation and Professional Photography.</p>
<p>And the CEDA Revolution is all about Professional Sales Executives, the heart and soul of Real Estate. Without the right Agent, homeowners and buyers are not able to achieve their dreams home ownership and real estate investment. The Ceda Revolution is all about preparing Sales Executives to use One-Touch iPAD Technology to serve more clients, literally from anywhere anytime.</p>
<p>Its high time for changes in our industry. The Ceda Revolution represents change from old technology, old methods of communication and old worn-out training which meet neither the needs of the modern REALTOR&reg; nor todays client culture. The Ceda Revolution equips agents for the FUTURE of Real Estate, utilzes the newest technology and above all, MAKES THE REAL ESTATE TRANSACTION A PLEASANT EXPERIENCE.</p>
eos
  s.style = ''
  s.meta_description = ''
  s.meta_keywords = ''
  s.published = true
  s.created_at = DateTime.new(2012, 5, 9, 19, 12, 51)
  s.updated_at = DateTime.new(2012, 6, 1, 18, 39, 13)

  id += 1
end

Post.seed do |s|
  s.id = id
  s.user_id = User.where(username: 'sgoff').first.id
  s.title = 'Many uses for the iPAD'
  s.slug = 'many-uses-for-the-ipad'
  s.body = <<-eos
<p>Apparently there are MANY uses for the iPAD - not just for real estate transactions. Check this out:</p>
<iframe src="http://www.snotr.com/embed/8965" width="400" height="330" frameborder="0"></iframe>
  eos
  s.style = ''
  s.meta_description = ''
  s.meta_keywords = ''
  s.published = true
  s.created_at = DateTime.new(2012, 6, 20, 14, 50, 49)
  s.updated_at = DateTime.new(2012, 6, 20, 14, 52, 1)

  id += 1
end
