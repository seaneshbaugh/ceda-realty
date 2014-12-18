id = 1

order = 0

Page.seed do |s|
  s.id = id
  s.parent_id = nil
  s.title = 'About'
  s.slug = 'about'
  s.full_path = '/about'
  s.body = <<-eos
<h2>About</h2>
<h3>About Our Name</h3>
<p>So whats with the name and horse? CEDA Realty specifically chose the American Paint Horse as its brand identity because of what it represents. The American Paint horse is known for being one of the hardest working breeds in America along with its beauty, intelligence, agility and strength. We think of our team as possessing the same qualities.</p>
<p>The name CEDA pronounced [Say-Dah] stands for, &quot;Culture of Excellence and Devoted Advocates.&quot; It's our mission to breed a culture of excellence and create devoted advocates out of all of our clients.</p>
<h3>C.E.D.A.</h3>
<p>A Culture of Excellence and Devoted Advocates</p>
<h3>Culture</h3>
<p>We are more than just a Company. Ceda Realty represents a new CULTURE in real estate marketing, offering premium services to both buyers and sellers. Instead of reducing value as discount brokers do, Ceda Realty actually increases the value of services, setting new standards for the real estate industry.</p>
<h3>Excellence</h3>
<p>Todays consumer is tired of settling for mediocrity. Ceda Realty seeks EXCELLENCE in every phase of our business. Nothing less is acceptable.</p>
<h3>Devoted</h3>
<p>More than dedicated, we are DEVOTED to our clients, DEVOTED to honest dealings with all parties to the transaction and DEVOTED to the highest standards of our industry.</p>
<h3>Advocates</h3>
<p>This word best describes our Sales Executives, who are more than mere agents. We always negotiate and act to the best of our ability representing the interests of our clients. Our goal is to be your real estate brokerage, and that of your family and friends, for life.</p>
eos
  s.style = ''
  s.script = ''
  s.meta_description = 'Company Info'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = nil
  s.title = 'Residential'
  s.slug = 'residential'
  s.full_path = '/residential'
  s.body = <<-eos
<h2>Residential Real Estate Service</h2>
<p>At CEDA Realty we take the term &quot;service&quot; literally and handle every client with a servant's heart. It's our duty to provide the best possible real estate experience for you throughout your transaction. Whether you are buying, selling or leasing we are there from start to finish. Find out how CEDA can assist you with all of your real estate needs!</p>
eos
  s.style = ''
  s.script = ''
  s.meta_description = 'Buyer\'s info'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = nil
  s.title = 'Commercial'
  s.slug = 'commercial'
  s.full_path = '/commercial'
  s.body = <<-eos
<h2>CEDA COMMERCIAL Real Estate</h2>
<p>
  <img src="/images/uploads/1302453706978641.jpg?1302453706" alt="" class="property_management">
  CEDA COMMERCIAL offers full-service Commercial Sales and Leasing for Office, Industrial, Retail, Land and Multi-Family real estate. Our experienced Commercial Sales Executives are ready to serve your business or real estate investment needs.
</p>
<h3>Investment Opportunities</h3>
<p>Our professional real estate investment team will advise you in all aspects of commercial property acquisition and development. We look forward to sharing our marketing ideas and capabilities with you in an effort to achieve the results you truly deserve.</p>
<h3>Commercial Sales & Leasing</h3>
<p>CEDA COMMERCIAL Sales Executives represent Commercial property owners to maximize exposure to buyers, not only through commercial websites but also using signage with QR scan codes and Mobile Marketing codes which push property information, photos, virtual tours and contact links to the Mobile phone of the Buyer Prospect.</p>
<h3>Tenant Representation</h3>
<p>CEDA COMMERCIAL specializes in assisting clients with securing the right real estate for their business. Your CEDA COMMERCIAL Sales Executive is a trusted resource for the location and negotiation of first class office space whether for lease or purchase, as well as for relocation, consolidations, subleases, acquisitions and dispositions.</p>
<h3>Development and Project Management</h3>
<p>We start by helping clients create a detailed Needs Analysis. Next we help you find the best location, negotiate the purchase, assemble your support team and create a road map to success. Then we coordinate the entire process from start to finish, allowing you to focus on your day to day priorities while the project moves forward.</p>
<p>Contact us today to schedule a free in-office development consultation.</p>
eos
  s.style = <<-eos
img.property_management {
  float: left;
  margin-right: 6px;
  width: 250px;
}
eos
  s.script = ''
  s.meta_description = ''
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

order = 0

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/about').first.id
  s.title = 'Partners'
  s.slug = 'partners'
  s.full_path = '/about/partners'
  s.body = <<-eos
<h2>Our Partners</h2>
<p>CEDA is excited to partner with the best experts in the industry.</p>
<div id="partners">
  <div class="partner">
    <a href="http://kdecker.fubmortgage.com/Default.aspx/">
      <img src="/images/uploads/1326921271940265.png?1326921272" alt="First United Bank">
    </a>
    <div class="partner_info">
      First United Bank<br>
      <a href="http://kdecker.fubmortgage.com/Default.aspx/contact_us.html">Contact</a><br>
      <a href="tel:214-908-6792">214-908-6792</a>
    </div>
  </div>
  <div class="partner">
    <a href="http://www.burgessinspection.com/">
      <img src="/images/uploads/1302521145948804.png?1302521145" alt="Burgess Inspection Group">
    </a>
    <div class="partner_info">
      Burgess Inspection Group<br>
      <a href="http://www.burgessinspection.com/index.php?option=com_content&view=article&id=76&Itemid=176">Contact</a><br>
      <a href="tel:800-888-5660">800-888-5660</a>
    </div>
  </div>
	<div class="partner">
		<a href="http://www.NinaGeorgeStaging.com/">
      <img src="/images/uploads/1401979221343143.png?1401979221" alt="Nina George">
    </a>
		<div class="partner_info">
			Nina George Staging<br>
			<a href="http://www.bymichellelynne.com/">Contact</a><br>
			<a href="tel:214-215-4228">214-214-4228</a>
		</div>
	</div>
  <div class="partner">
  	<a href="http://academymortgage.com/lo/coryherell#.VIoNXyvF9r8/">
      <img src="/images/uploads/1418333329232681.jpg?1418333329" alt="Cory Herell">
    </a>
  	<div class="partner_info">
  		Academy Mortgage<br>
  		<a href="http://academymortgage.com/lo/coryherell#.VIoNXyvF9r8/">Contact</a><br>
  		<a href="tel:469-440-5184">972-838-3605</a>
  	</div>
  </div>
  <div class="partner">
  	<a href="http://www.deaninsure.com/">
      <img src="/images/uploads/1319473711645222.jpg?1319473711" alt="Dean Insurance Group">
    </a>
  		<div class="partner_info">
  			Dean Insurance Group<br>
  			<a href="http://www.deaninsure.com/">Contact</a><br>
  			<a href="tel:972-781-1115">214-227-9377</a>
  		</div>
  	</div>
  </div>
</div>
eos
  s.style = <<-eos
div.partner {
  float: left;
  height: 200px;
  margin-left: 10px;
  text-align: center;
  width: 225px;
}
eos
  s.script = ''
  s.meta_description = 'CEDA Partners'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/about').first.id
  s.title = 'Careers'
  s.slug = 'careers'
  s.full_path = '/about/careers'
  s.body = <<-eos
<h2>Careers</h2>
<p>Let us first start off by saying, we're not like the other guys. As a matter of fact we are completely different than any other real estate company out there. We harness technology, innovation and community! Contact Steve Goff at 972-824-5312 or steve@cedarealty.com today to talk about how we can take your career to the next level!</p>
<h2>Career Benefits</h2>
<ul class="career_benefits">
  <li>CEDA Sales Executives are gifted an iPad loaded with buyer/seller presentations and forms</li>
  <li>No Franchise Fee</li>
  <li>Competitive Compensation Plan with Cap</li>
  <li>Free Yard Signs with 100% Call Capture</li>
  <li>Free In-House Advanced Training</li>
  <li>Free CEDA Marketing templates</li>
  <li>Free CEDA Virtual Tours Provided</li>
  <li>In-House Advertising/Marketing + Graphic Design for Custom Branding</li>
  <li>Residual Bonus Income Paid Monthly</li>
</ul>
<p><img src="/images/uploads/1305129358413639.png?1305129358" alt="Careers" id="careers"></p>
eos
  s.style = <<-eos
ul.career_benefits {
  color: #999999;
  font-size: 12px;
  line-height: 20px;
  list-style: none;
  margin-bottom: 15px;
  margin-left: 0;
}

img#careers {
  height: 200px;
}
eos
  s.script = ''
  s.meta_description = 'CEDA Realty Careers'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

order = 0

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/residential').first.id
  s.title = 'CEDA Certified'
  s.slug = 'ceda-certified'
  s.full_path = '/about/ceda-certified'
  s.body = <<-eos
<h2>CEDA Certified</h2>
<h3>Our premium CEDA Certified Homes will include</h3>
<ul class="ceda_certified">
  <li>Consultation with Professional Home Stager</li>
  <li>Pre-Listing Inspection</li>
  <li>C.L.U.E. Report</li>
  <li>Title Property Profile</li>
  <li>Professional Photography</li>
  <li>Mobile Marketing & Call Information Capture</li>
</ul>
<h3>Our premium CEDA Certified Buyer Services include</h3>
<ul class="ceda_certified">
  <li>In-House Lender Pre-Approval</li>
  <li>Represented by CEDA Sales Executive</li>
  <li>Auto MLS and Mobile Search</li>
  <li>Courtesy Insurance Quotes</li>
  <li>Free Utility Concierge</li>
  <li>Resources for Professional Space Planning and Design</li>
</ul>
eos
  s.style = <<-eos
ul.ceda_certified {
  color: #999999;
  font-size: 12px;
  line-height: 20px;
  list-style: none;
  margin-bottom: 15px;
  margin-left: 10px;
}
eos
  s.script = ''
  s.meta_description = 'CEDA Certified'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = nil
  s.title = 'Buy'
  s.slug = 'buy'
  s.full_path = '/residential/buy'
  s.body = <<-eos
<h2 class="typeface-js">Buying Your Home</h2>
<p>Buying a home can be a confusing experience for the first-time and even experienced buyer. This is why we try to make the experience as simple and streamlined as possible. Below are the simple steps to purchasing a home. Please feel free to reference back to these steps to get yourself comfortable with the buy process.</p>
<h3>Get Pre-Approved By a Lender</h3>
<p>The critical first step to buying a home is to meet with a qualified home lender and have them prepare a pre-approval for you. The lender can then access if you are qualified to purchase a home. The lender will look at credit score, debt to income ratio and other criteria to determine this. Once you have your pre-approval letter you are ready to begin your search.</p>
<h3>Get Representation</h3>
<p>This is where you hire us to represent you in your real estate transaction. It\'s important to hire a real estate professional to guide you through the real estate process. Best of all it\'s a free service to you. A REALTORS commission is paid for by the Seller.<p>
<h3>Needs + Wants</h3>
<p>Prior to beginning the search for your perfect home, we help define that perfect home just for you! We discuss your needs and wants and weigh each of these factors to simplify the search for your new home. Click through to home buyer preference sheet.</p>
<h3>Home Search</h3>
<p>We devise a home search strategy specific to your needs designed to make you a competitive shopper. We give you several easy-to-use tools and methods to search for your new home. In addition, we set up automated homes searches that continually inform you of the status of the current market through email.</p>
<h3>Negotiations</h3>
<p>This is the flagship of our value to you as a home buyer. We will help you thoroughly analyze the market so you can best determine a fair price for your new home. We will provide all of the necessary paperwork, plus guide you throughout the negotiations.</p>
<h3>Contract to Close</h3>
<p>Before we enter into a contract we must first come up with an offer price on the home of interest. This is determined by reviewing past sold homes and other criteria. When we submit the offer we will attach in the following order:</p>
<ul class="contract_to_close">
  <li>Cover sheet</li>
  <li>Pre-Approval from lender</li>
  <li>1-4 Family Residential Offer/Or Condo</li>
  <li>Third Party Financing Addendum</li>
  <li>Copy of Option Fee (a negotiable amount usually $50-100) which will allow us to inspect the home (a negotiated period generally no longer than 10 days)</li>
  <li>Copy of Earnest Fee which is like a deposit that is cashed in a third-party escrow account written to Title Company. This fee will show up as a credit to buyer at closing if you proceed with transaction. If you exceed option then back out of contract this fee will be retained by seller for buyer default.</li>
</ul>
<p>Once a price is agreed upon we will be under contract and go through the following steps:</p>
<ul class="contract_to_close">
  <li>Deliver Option Fee to seller within 2 days</li>
  <li>Deliver Earnest Fee to Title Company within 2 days</li>
  <li>Get a Home Inspection to assure home is in good standing (we will provide list of inspectors for you). Write inspector check (fees vary).</li>
  <li>Negotiate repairs if necessary</li>
  <li>If seller is unwilling to negotiate or if you need to cancel contract do so now prior to ending of option period.</li>
  <li>After option expires continue to get loan approval</li>
  <li>Appraisal</li>
  <li>Title Work and Commitment</li>
  <li>Review Survey & HOA docs (if any)</li>
  <li>Close on Home!</li>
</ul>
eos
  s.style = <<-eos
ul.contract_to_close {
  color: #999999;
  font-size: 12px;
  line-height: 20px;
  list-style: none;
  margin-bottom: 15px;
  margin-left: 10px;
}
eos
  s.script = ''
  s.meta_description = 'CEDA Realty information for buyers.'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/residential').first.id
  s.title = 'Sell'
  s.slug = 'sell'
  s.full_path = '/residential/sell'
  s.body = <<-eos
<h2>Selling Your Home</h2>
<p>Sometimes, life just hands us the inevitable: just when everything seems right with your home, something happens and you have to sell your dwelling. No matter what your reasons are for selling, remember that now is no time to dawdle, the process of preparing a home for sale can take a month or more. So, heres how to start:</p>
<h3>1. Take a Fresh Look at Your Home</h3>
<p>Your home looks great to you, but a buyer wants to see it since he and his family will be living in it  so take a fresh look at your dwelling. Hop in your car, drive around the block, and then scrutinize your home as a prospective buyer will see it for the first time. First, consider whats called &quot;street appeal;&quot; does it need washing or painting? Does the driveway need repair work? Is the landscaping in good shape? Remember, be very critical; your buyer will be.</p>
<p>Next, pull into the driveway and take a good, hard look. Is the yard neat and trimmed? What about the view from the front yard? Then, walk inside and size up the interior as though seeing it for the first time. Take a tour and imagine what your real estate agent might say about each room, look into cabinets, open doors, check out the bathroom.<p>
<p>Then, make a mental note of the things that might put off potential buyers, along with another list of the things that first attracted you to the dwelling. Remember, the homes become a great place for you, but a new buyer will see things that you dont.</p>
<h3>2. Clean Out the Clutter Before You Start to Sell</h3><p>
<p>Before putting your home on the market, get rid of clutter in every area  closets, attic storage, kitchen cabinets,drawers, bath vanities, and shelves  everywhere. Remember, this is no time to be sentimental: if you dont use it, lose it. Potential buyers are seriously put off by clutter, and most of us drag a lot more things through life than we really need.</p>
<p>Also, dont forget the furniture and fixtures when getting rid of clutter  most of us put too much in too little space, which makes a buying prospect think your home is too small.</p>
<p>Then, have a great moving sale with all the stuff youve collected and use the proceeds for paint or whatever other materials you need for repair projects. If you just cant bear to part with some possessions, store them in the attic or some other place thats out of sight to a potential buyer.</p>
<h3>3. To Sell, Sell, Sell  Clean, Clean, Clean</h3>
<p>After youve cleared out the clutter, its time to really clean. Have the carpets professionally cleaned, strip and polish the floors, scour the bathrooms, go over the laundry room, polish the furniture, scour out the cabinets, wash the windows and window coverings, and spiff up the ceiling fans and kitchen appliances. In short, clean everything.</p>
<p>Dont forget the exterior; paint or power-wash everything that needs the work. Remember, this is a ceiling-to-floor, roof-to-foundation clean-up project.</p>
<h3>4. Get More for Your Home: Repairs Pay Off</h3>
<p>After youve cleaned the place to within an inch of its life, the next project is making all the repairs necessary to attract a buyer.</p>
<p>So, patch up the roof, touch up all the paint, repair the screens, spruce up the porch framing, and make your entry area really shine. Dont forget to water the lawn and landscape beds, and take the time to trim, mow, edge and get rid of sick or dying plants. Inside, fix the grout in the bathrooms and on tile floors, adjust any doors that need it, fix any scratches on the walls, cover any stains, and be sure to fix any plumbing problems. Remember, do what your home needs before the first buyer appears at your door.</p>
<p>Also, its a good idea to get all this done before getting the real estate broker to make the first listing  a good agent will advise you on what needs to be done. Also, if you have friends willing to be brutally honest about what your home needs to sell, invite them to assess the fix-up needs.</p>
<p>There is, however, an alternative to the sweat equity you get from a total fix-up but it carries a price. An &quot;as-is&quot; sale keeps you from doing all this work, but a buyer will assess about twice the price you would have paid for the repairs. Then, the buyer will deduct that amount from your asking price before making an offer.</p>
<h3>5. Putting Your Home on the Market: Show It to Sell It</h3>
<p>After you have cleaned, shined, mowed, and generally whipped your property into shape, its time to attract a buyer.</p>
<p>Regardless of who markets your home, you or a broker, there are other, small things you must do to attract buyers. For example, even if its bright daylight, open the blinds and turn on the lights. Also, open all the interior doors to make the home appear roomier. Be sure to remove all your kids and pets  theyre cute, but a prospect wants to see your home, not your pride and joy.</p>
<p>In addition, make sure your pets litter pan is clean so the home smells clean and fresh, not like air freshener. Remember, you need to make sure your home is available to be seen by a prospective buyer with as little notice as possible. That means less than an hour, or even five minutes, if possible.</p>
<h3>6. Get a Sense of the Market</h3>
<p>Before you put your home on the market, take a weekend day to check out the competition: homes with similar prices and in similar neighborhoods. Remember, you dont have to go out and buy new furniture just to look like that beautiful new model in the new development  what you want is the feel of that new model  clean, uncluttered, and fresh.</p>
<p>Remember, after location, the most important item to a buyer is a well maintained home. Many flaws can be overlooked if the buyer knows he can move in without a lot of trouble and expense.</p>
eos
  s.style = ''
  s.script = ''
  s.meta_description = 'CEDA Realty information for sellers.'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/residential').first.id
  s.title = 'Leasing'
  s.slug = 'leasing'
  s.full_path = '/residential/leasing'
  s.body = <<-eos
<h2>Leasing</h2>
<p>Searching for a home or apartment to lease can be an overwhelming task. CEDA Realty offers a free apartment search and also homes for lease. Whatever you are looking for in the metroplex CEDA Realty can assist you.</p>
<p>But it doesnt stop there. Unlike other locating services CEDA Realty is a full-service real estate service and can not only show you ALL leases but prepare you for a purchase in the near future.</p>
eos
  s.style = ''
  s.script = ''
  s.meta_description = 'CEDA Realty leasing information.'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/residential').first.id
  s.title = 'Apartment Search'
  s.slug = 'apartment-search'
  s.full_path = '/residential/apartment-search'
  s.body = <<-eos
<h2>Apartment Search</h2>
<p>CEDA Realty offers full-service apartment locating. We can locate and find the right apartment for you to lease whether you are relocating or looking to lease temporarily our agents will help you locate the perfect place. Our apartment locating services are free to you. So why wait? Get with one of our agents today to assist you with your apartment lease. our dedicated agents can locate an apartment based on your specs and setup an appointment to view the apartments that best meet your needs. Trying to call apartments, set appointments and work with apartment managers can be time consuming. We take the hassle out of apartment hunting.</p>
eos
  s.style = ''
  s.script = ''
  s.meta_description = ''
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/residential').first.id
  s.title = 'Communities'
  s.slug = 'communities'
  s.full_path = '/residential/communities'
  s.body = <<-eos
<h2>Community</h2>
<p>Home is where the heart is. Let's face it when you are buying real estate you are really buying a lifestyle. Here's the good news, you couldn't find a better lifestyle anywhere else in the world. The Dallas Ft. Worth area is one of the best places to live on earth, with a low-cost of living, excellent entertainment, some of the best sports teams in the nation (sometimes) and great weather. What else can you ask for? We're also a stone's throw form Austin, San Antonio, and Houston. Explore some of the great communities in the DFW area and allow CEDA Realty to find help you find the home of your dreams!</P>
<h3>Far North Dallas</h3>
<ul class="community">
  <li><a href="http://www.planoonline.com/">Plano</a></li>
  <li><a href="http://www3.mckinneytexas.org/www/default.aspx">McKinney</a></li>
  <li><a href="http://www.cityofallen.org/">Allen</a></li>
  <li><a href="http://www.friscotexas.gov/Pages/Default.aspx">Frisco</a></li>
  <li><a href="http://www.ci.the-colony.tx.us/">The Colony</a></li>
  <li><a href="http://www.littleelm.org/">Little Elm</a></li>
</ul>
<h3>North Dallas</h3>
<ul class="community">
  <li><a href="http://www.addisontexas.net/">Addison</a></li>
  <li><a href="http://www.cityofcarrollton.com/">Carrollton</a></li>
  <li><a href="http://www.cor.net/">Richardson</a></li>
  </ul>
<h3>Central Dallas</h3>
<ul class="community">
  <li><a href="http://www.dallascityhall.com/">Dallas</a></li>
  <li><a href="http://www.dallaswestend.org/">West End</a></li>
  <li><a href="http://www.downtowndallas.org/">Downtown</a></li>
  <li><a href="http://www.uptowndallas.net/">Uptown</a></li>
  <li><a href="http://www.sahd.org/">Swiss Avenue</a></li>
  <li><a href="http://www.lakewoodneighborhood.org/">Lakewood</a></li>
  <li><a href="http://www.whiterocklake.org/">White Rock Lake</a></li>
  <li><a href="http://www.oakcliff.com/">Oakcliff</a></li>
  <li><a href="http://www.kesslerpark.org/">Kessler Park</a></li>
  <li><a href="http://www.hptx.org/">Highland Park</a></li>
  <li><a href="http://www.uptexas.org/index.cfm?FuseAction=Page&PageID=000001">University Park</a></li>
  <li><a href="http://www.ci.coppell.tx.us/">Coppell</a></li>
</ul>
eos
  s.style = <<-eos
ul.community {
  color: #999999;
  font-size: 12px;
  line-height: 20px;
  list-style: none;
  margin-bottom: 15px;
  margin-left: 10px;
}
eos
  s.script = ''
  s.meta_description = ''
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/residential').first.id
  s.title = 'Luxury Homes'
  s.slug = 'luxury-home'
  s.full_path = '/residential/luxury-homes'
  s.body = <<-eos
<h2>LUXURY HOME DIVISION</h2>
<p>
  <img src="/images/uploads/1339011305549730.jpg?1339011306" alt="" class="luxury_homes">
  CEDA REALTY presents unique marketing for LUXURY HOMES, including special signage, mobile phone data, professional photography, exquisite virtual tour presentation and more.
</p>
<h3>Special Web Placement</h3>
<p>Our Sales Executives receive preferred placement for our Luxury Homes on Realtor.com, the number one real estate property search website in the world. We target market Luxury Homes to high end buyers.</p>
<h3>Special Financing</h3>
<p>CEDA REALTY Luxury Homes have special Jumbo Loan pricing available through our in-house lender, which helps the home become more affordable to buyers. Each sign caller is given the opportunity to receive information on Luxury Home financing options as well as receive a speedy loan approval.</p>
eos
  s.style = <<-eos
img.luxury_homes {
  float: left;
  margin-right: 6px;
  width: 250px;
}
eos
  s.script = ''
  s.meta_description = ''
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end

order = 0

Page.seed do |s|
  s.id = id
  s.parent_id = Page.where(full_path: '/commercial').first.id
  s.title = 'Developer Services'
  s.slug = 'developer-services'
  s.full_path = '/commercial/developer-services'
  s.body = <<-eos
<h2>Developer Services</h2>
<p>
  <img src="/images/uploads/1302453549982911.jpg?1302453549" alt="" class="developer_services">
  CEDA Realty offers all inclusive Developer Services to current builders or builders who are thinking of building in the DFW area. We can take over at any step of the way. With our knowledgeable agents and in house marketing team, working with CEDA Realty is a win-win. Let's talk about how we can market and sell your development in the growing DFW Metroplex. We offer cost-effective solutions for builders to achieve big results with limited capital. You will be more than impressed with our out-of-the-box marketing approach and tech-savvy. Call us today to setup an appointment to discuss your builder needs.
</p>
<h3>Pre-Development Services</h3>
<p>CEDA Realty will assist with site selection, overall concept and design, demographic research, financing partnerships and execution of idea. A turn-key solution from small to large.<p>
<h3>Marketing + Advertising Services</h3>
<ul class="developer_services">
  <li>Press release and launch</li>
  <li>Website design and creation</li>
  <li>Web and social media marketing</li>
  <li>Print marketing</li>
  <li>Realtor/Broker marketing</li>
  <li>Promotional Marketing</li>
  <li>On-site sales assistance</li>
</ul>
eos
  s.style = <<-eos
img.developer_services {
  float: left;
  margin-right: 6px;
  width: 250px;
}

ul.developer_services {
  color: #999999;
  font-size: 12px;
  line-height: 20px;
  list-style: none;
  margin-bottom: 15px;
  margin-left: 10px;
}
eos
  s.script = ''
  s.meta_description = 'CEDA Realty developer services.'
  s.meta_keywords = ''
  s.show_in_menu = true
  s.published = true
  s.order = order

  id += 1
  order += 1
end
