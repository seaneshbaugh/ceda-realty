abr = Designation.where(name: 'Accredited Buyer\'s Representative').first
abrm = Designation.where(name: 'Accredited Buyer Representative Manager').first
ahwd = Designation.where(name: 'At Home With Diversity').first
alc = Designation.where(name: 'Accredited Land Consultant').first
alhs = Designation.where(name: 'Accredited Luxury Home Specialist').first
ccim = Designation.where(name: 'Certified Commercial Investment Member').first
cdpe = Designation.where(name: 'Certified Distressed Property Expert').first
cips = Designation.where(name: 'Certified International Property Specialist').first
cpm = Designation.where(name: 'Certified Property Manager').first
crb = Designation.where(name: 'Certified Real Estate Brokerage Manager').first
cre = Designation.where(name: 'Counselor of Real Estate').first
crs = Designation.where(name: 'Certified Residential Specialist').first
epro = Designation.where(name: 'e-PRO').first
gaa = Designation.where(name: 'General Accredited Appraiser').first
green = Designation.where(name: 'Green').first
gri = Designation.where(name: 'Graduate Realtor Institute').first
ihlm = Designation.where(name: 'Institute for Home Luxury Marketing Certification').first
ires = Designation.where(name: 'International Real Estate Specialist').first
pmn = Designation.where(name: 'Performance Management Network').first
raa = Designation.where(name: 'Residential Accredited Appraiser').first
rce = Designation.where(name: 'Realtor Association Certified Executive').first
repa = Designation.where(name: 'Real Estate Professional Assistant').first
rsps = Designation.where(name: 'Resort and Second-Home Property Specialist').first
sfr = Designation.where(name: 'Short Sales & Foreclosure Resource').first
sior = Designation.where(name: 'Society of Industrial and Office Realtors').first
sres = Designation.where(name: 'Seniors Real Estate Specialist').first
tahs = Designation.where(name: 'Texas Affordable Housing Specialist').first
trc = Designation.where(name: 'Transnational Referral Certification').first

steve_goff = User.where(username: 'sgoff').first.profile
steve_goff.designations += [cdpe, crb, ires, sfr]
