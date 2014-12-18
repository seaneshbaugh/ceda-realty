class Picture < ActiveRecord::Base
  belongs_to :profile

  belongs_to :office

  has_attached_file :file, {
    convert_options: {
      thumbnail: '-auto-orient -quality 75 -strip',
      medium: '-auto-orient -quality 85 -strip' },
    path: ":rails_root/public/uploads/#{Rails.env.test? ? 'test/' : ''}images/:style_prefix:basename.:extension",
    styles: {
      thumbnail: '100x100>',
      medium: '500x500>' },
    url: "/uploads/#{Rails.env.test? ? 'test/' : ''}images/:style_prefix:basename.:extension" }

  validates_length_of   :name, maximum: 255
  validates_presence_of :name

  validates_length_of :alt_text, maximum: 255

  validates_uniqueness_of :file_fingerprint, if: -> { !Rails.env.test? }

  validates_attachment_presence :file
  validates_attachment_size :file, less_than: 4096.megabytes
  validates_attachment_content_type :file, content_type: %w(image/gif image/jpeg image/jpg image/pjpeg image/png image/svg+xml image/tiff image/x-png)

  before_validation :modify_file_file_name
  before_validation :set_default_name

  before_post_process :image?
  after_post_process :save_image_dimensions

  protected

  def modify_file_file_name
    if file.file?
      if file.dirty?
        current_time = Time.now

        basename = "#{current_time.to_i}#{current_time.usec}".ljust(16, '0')

        extension = File.extname(file_file_name).downcase

        if extension == '.jpeg'
          extension = '.jpg'
        end

        if extension == '.tif'
          extension = '.tiff'
        end

        file.instance_write :file_name, "#{basename}#{extension}"
      end
    end
  end

  def set_default_name
    self.name = File.basename(file_file_name, '.*').to_s if name.blank? && !file_file_name.blank?
  end

  def image?
    self.errors.add :file, 'is not an image'

    !(image_content_type =~ /^image.*/).nil?
  end

  def save_image_dimensions
    original_geometry = Paperclip::Geometry.from_file(image.queued_for_write[:original])
    self.image_original_width = original_geometry.width
    self.image_original_height = original_geometry.height

    medium_geometry = Paperclip::Geometry.from_file(image.queued_for_write[:medium])
    self.image_medium_width = medium_geometry.width
    self.image_medium_height = medium_geometry.height

    thumbnail_geometry = Paperclip::Geometry.from_file(image.queued_for_write[:thumbnail])
    self.image_thumbnail_width = thumbnail_geometry.width
    self.image_thumbnail_height = thumbnail_geometry.height
  end
end
