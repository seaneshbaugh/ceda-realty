class Document < ActiveRecord::Base
  has_attached_file :file, {
    path: ":rails_root/public/uploads/#{Rails.env.test? ? 'test/' : ''}documents/:style_prefix:basename.:extension",
    url: "/uploads/#{Rails.env.test? ? 'test/' : ''}documents/:style_prefix:basename.:extension" }

  validates_length_of   :name, maximum: 255
  validates_presence_of :name

  validates_uniqueness_of :file_fingerprint, if: -> { !Rails.env.test? }

  validates_attachment_presence :file
  validates_attachment_size :file, less_than: 4096.megabytes
  validates_attachment_content_type :file, content_type: { not: %w(application/bat
                                                                   application/com
                                                                   application/exe
                                                                   application/hta
                                                                   application/x-bat
                                                                   application/x-com
                                                                   application/x-download
                                                                   application/x-exe
                                                                   application/x-javascript
                                                                   application/x-ms-shortcut
                                                                   application/x-msdos-program
                                                                   application/x-msdos-windows
                                                                   application/x-msdownload
                                                                   application/x-msi
                                                                   application/x-winexe
                                                                   application/x-winhelp
                                                                   application/x-winhlp
                                                                   vms/exe) }

  before_validation :modify_file_file_name
  before_validation :set_default_name

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
    title = File.basename(file_file_name, '.*').to_s if name.blank? && !file_file_name.blank?
  end
end
