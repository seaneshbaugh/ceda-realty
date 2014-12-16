class Picture < ActiveRecord::Base
  has_attached_file :file, {
    convert_options: {
      thumbnail: '-quality 75 -strip',
      medium: '-quality 85 -strip' },
    path: ":rails_root/public/uploads/#{Rails.env.test? ? 'test/' : ''}:class_singular/:attachment/:style_prefix:basename.:extension",
    styles: {
      thumbnail: '100x100',
      medium: '500x500' },
    url: "/uploads/:class_singular/:attachment/#{Rails.env.test? ? 'test/' : ''}:style_prefix:basename.:extension" }

  validates_length_of   :name, maximum: 255
  validates_presence_of :title

  validates_length_of :alt_text, maximum: 255

  validates_uniqueness_of :image_fingerprint, if: -> { !Rails.env.test? }

  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 4096.megabytes
  validates_attachment_content_type :image, content_type: %w(image/gif image/jpeg image/jpg image/pjpeg image/png image/svg+xml image/tiff image/x-png)

  before_validation :modify_image_file_name
  before_validation :set_default_title

  before_post_process :image?
  after_post_process :save_image_dimensions

  protected

  def modify_image_file_name
    if image.file?
      if image.dirty?
        current_time = Time.now

        basename = "#{current_time.to_i}#{current_time.usec}".ljust(16, '0')

        extension = File.extname(self.image_file_name).downcase

        if extension == '.jpeg'
          extension = '.jpg'
        end

        if extension == '.tif'
          extension = '.tiff'
        end

        self.image.instance_write :file_name, "#{basename}#{extension}"
      end
    end
  end

  def set_default_title
    self.title = File.basename(self.image_file_name, '.*').to_s if self.title.blank? && !self.image_file_name.blank?
  end

  def image?
    self.errors.add :image, 'is not an image'

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
