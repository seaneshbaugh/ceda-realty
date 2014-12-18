require 'shellwords'

pictures = [
  { fixture_filename: 'designations/abr.png', original_filename: '1418924972916856.png', name: 'Accredited Buyer\'s Representative', alt_text: '' },
  { fixture_filename: 'designations/abrm.png', original_filename: '1418924973644815.png', name: 'Accredited Buyer Representative Manager', alt_text: '' },
  { fixture_filename: 'designations/ahwd.png', original_filename: '1418924973767374.png', name: 'At Home With Diversity', alt_text: '' },
  { fixture_filename: 'designations/alc.png', original_filename: '1418924974650477.png', name: 'Accredited Land Consultant', alt_text: '' },
  { fixture_filename: 'designations/alhs.png', original_filename: '1418924974850547.png', name: 'Accredited Luxury Home Specialist', alt_text: '' },
  { fixture_filename: 'designations/ccim.png', original_filename: '1418924975467023.png', name: 'Certified Commercial Investment Member', alt_text: '' },
  { fixture_filename: 'designations/cdpe.png', original_filename: '1418924976191590.png', name: 'Certified Distressed Property Expert', alt_text: '' },
  { fixture_filename: 'designations/cips.png', original_filename: '1418924976105719.png', name: 'Certified International Property Specialist', alt_text: '' },
  { fixture_filename: 'designations/cpm.png', original_filename: '1418924976155454.png', name: 'Certified Property Manager', alt_text: '' },
  { fixture_filename: 'designations/crb.png', original_filename: '1418924976562468.png', name: 'Certified Real Estate Brokerage Manager', alt_text: '' },
  { fixture_filename: 'designations/cre.png', original_filename: '1418924977286608.png', name: 'Counselor of Real Estate', alt_text: '' },
  { fixture_filename: 'designations/crs.png', original_filename: '1418924977422466.png', name: 'Certified Residential Specialist', alt_text: '' },
  { fixture_filename: 'designations/epro.png', original_filename: '1418924977858684.png', name: 'e-PRO', alt_text: '' },
  { fixture_filename: 'designations/gaa.png', original_filename: '1418924977862384.png', name: 'General Accredited Appraiser', alt_text: '' },
  { fixture_filename: 'designations/green.png', original_filename: '1418924978388060.png', name: 'Green', alt_text: '' },
  { fixture_filename: 'designations/gri.png', original_filename: '1418924978228315.png', name: 'Graduate Realtor Institute', alt_text: '' },
  { fixture_filename: 'designations/ihlm.png', original_filename: '1418924979228592.png', name: 'Institute for Home Luxury Marketing Certification', alt_text: '' },
  { fixture_filename: 'designations/ires.png', original_filename: '1418924979282010.png', name: 'International Real Estate Specialist', alt_text: '' },
  { fixture_filename: 'designations/pmn.png', original_filename: '1418924980180692.png', name: 'Performance Management Network', alt_text: '' },
  { fixture_filename: 'designations/raa.png', original_filename: '1418924980369054.png', name: 'Residential Accredited Appraiser', alt_text: '' },
  { fixture_filename: 'designations/rce.png', original_filename: '1418924981101749.png', name: 'Realtor Association Certified Executive', alt_text: '' },
  { fixture_filename: 'designations/repa.png', original_filename: '1418924981707808.png', name: 'Real Estate Professional Assistant', alt_text: '' },
  { fixture_filename: 'designations/rsps.png', original_filename: '1418924981749936.png', name: 'Resort and Second-Home Property Specialist', alt_text: '' },
  { fixture_filename: 'designations/sfr.png', original_filename: '1418924982527437.png', name: 'Short Sales & Foreclosure Resource', alt_text: '' },
  { fixture_filename: 'designations/sior.png', original_filename: '1418924983107800.png', name: 'Society of Industrial and Office Realtors', alt_text: '' },
  { fixture_filename: 'designations/sres.png', original_filename: '1418924983779637.png', name: 'Seniors Real Estate Specialist', alt_text: '' },
  { fixture_filename: 'designations/tahs.png', original_filename: '1418924983888842.png', name: 'Texas Affordable Housing Specialist', alt_text: '' },
  { fixture_filename: 'designations/trc.png', original_filename: '1418924984201702.png', name: 'Transnational Referral Certification', alt_text: '' }
]

fixture_file_directory = Rails.root.join('db', 'fixtures', 'files', 'images')

output_directory = Rails.root.join('public', 'uploads', 'images')

FileUtils.mkdir_p(output_directory)

pictures.each_with_index do |picture, id|
  fixture_file_path = File.join(fixture_file_directory, picture[:fixture_filename])

  original_file_path = File.join(output_directory, picture[:original_filename])

  # medium_filename = "#{File.basename(picture[:original_filename], '.*')}-medium#{File.extname(picture[:original_filename])}"
  medium_filename = "medium_#{picture[:original_filename]}"

  medium_file_path = File.join(output_directory, medium_filename)

  # thumbnail_filename = "#{File.basename(picture[:original_filename], '.*')}-thumbnail#{File.extname(picture[:original_filename])}"
  thumbnail_filename = "thumbnail_#{picture[:original_filename]}"

  thumbnail_file_path = File.join(output_directory, thumbnail_filename)

  content_type = Cocaine::CommandLine.new('file', '-b --mime :file').run(file: Shellwords.escape(fixture_file_path)).split(/[:;]\s+/).first

  puts "cp #{fixture_file_path} #{original_file_path}"

  FileUtils.cp(fixture_file_path, original_file_path)

  puts "convert '#{original_file_path}' -auto-orient -quality 85 -strip -resize 500x500\\> '#{medium_file_path}'"

  Cocaine::CommandLine.new('convert', ':original_file_path -auto-orient -quality 85 -strip -resize 500x500\> :medium_file_path').run(original_file_path: Shellwords.escape(original_file_path), medium_file_path: Shellwords.escape(medium_file_path))

  puts "convert '#{original_file_path}' -auto-orient -quality 75 -strip -resize 100x100\\> '#{medium_file_path}'"

  Cocaine::CommandLine.new('convert', ':original_file_path -auto-orient -quality 75 -strip -resize 100x100\> :thumbnail_file_path').run(original_file_path: Shellwords.escape(original_file_path), thumbnail_file_path: Shellwords.escape(thumbnail_file_path))

  original = Magick::Image.read(original_file_path).first

  original_width = original.columns

  original_height = original.rows

  medium = Magick::Image.read(medium_file_path).first

  medium_width = medium.columns

  medium_height = medium.rows

  thumbnail = Magick::Image.read(thumbnail_file_path).first

  thumbnail_width = thumbnail.columns

  thumbnail_height = thumbnail.rows

  Picture.seed do |s|
    s.id = id + 1
    s.name = picture[:name]
    s.alt_text = picture[:alt_text]
    s.file_file_name = picture[:original_filename]
    s.file_content_type = content_type
    s.file_file_size = File.size(fixture_file_path)
    s.file_updated_at = DateTime.now
    s.file_fingerprint = Digest::MD5.file(fixture_file_path).to_s
    s.file_original_width = original_width
    s.file_original_height = original_height
    s.file_medium_width = medium_width
    s.file_medium_height = medium_height
    s.file_thumbnail_width = thumbnail_width
    s.file_thumbnail_height = thumbnail_height

    id += 1
  end
end
