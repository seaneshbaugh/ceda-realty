require "digest/sha2"
require "RMagick"
require "textmodule"

class Picture < ActiveRecord::Base
	include TextModule

	belongs_to :attachable, :polymorphic => true

	has_one :agent

	#before destroying the object make sure we delete the image from the disk!
	def before_destroy
		result, message = self.delete_image

		if result != true
			raise message
		end

		return result
	end

	def id_with_title
		return self.id.to_s + ": " + self.title
	end

	def save_image(image)
		if image.class == ActionController::UploadedTempfile or image.class == Tempfile or image.class == ActionController::UploadedStringIO
			if image.size != 0
				result, message = Picture.validate_image_content_type(image)

				if result != true
					return false, message
				end

				self.sha2_checksum = Picture.calculate_checksum(image)

				pictures = Picture.find_by_sha2_checksum(self.sha2_checksum)

				if !pictures.nil?
					return false, "Error: Duplicate file uploaded!"
				end

				result, message = self.delete_image

				if result != true
					return false, message
				end

				self.image_filename, self.thumbnail_filename = Picture.write_image_to_disk(image, self.max_thumbnail_width, self.max_thumbnail_height)
			else
				return false, "Error: 0 length file."
			end
		else
			return false, "Error: Invalid data type uploaded."
		end

		return true, nil
	end

	def delete_image
		if !self.image_filename.nil?
			result, message = Picture.delete_image_from_disk(File.join("public/images/uploads", self.image_filename))

			if result != true
				return false, message
			end

			self.image_filename = nil
		end

		if !self.thumbnail_filename.nil?
			result, message = Picture.delete_image_from_disk(File.join("public/images/uploads/thumbnails", self.thumbnail_filename))

			if result != true
				return false, message
			end

			self.thumbnail_filename = nil
		end

		return true, nil
	end

	def image_path
		if image_filename.blank?
			return nil
		else
			return File.join("uploads", self.image_filename)
		end
	end

	def thumbnail_path
		if thumbnail_filename.blank?
			return nil
		else
			return File.join("uploads/thumbnails", self.thumbnail_filename)
		end
	end

	def self.validate_image_content_type(image)
		if !image.nil?
			if image.size != 0
				if image.content_type != "image/gif" and image.content_type != "image/jpeg" and image.content_type != "image/png" and image.content_type != "image/svg+xml" and image.content_type != "image/tiff"
					return false, "Error: Invalid file type. Only GIF, JPEG, PNG, SVG, and TIFF are supported."
				end
			else
				return false, "Error: 0 length file."
			end
		else
			return false, "Error: null file."
		end

		return true, nil
	end

	def self.calculate_checksum(image)
		image_data = image.read

		image.rewind

		return Digest::SHA256.hexdigest(image_data)
	end

	def self.get_extension(content_type, original_filename)
		case content_type
			when "image/gif"
				return "gif"
			when "image/jpeg"
				return "jpg"
			when "image/png"
				return "png"
			when "image/svg+xml"
				return "svg"
			when "image/tiff"
				return "tif"
			else
				return original_filename.split(".").last.downcase
		end
	end

	def self.write_image_to_disk(image, thumbnail_width, thumbnail_height)
		timestamp = Time.now.to_i.to_s + Time.now.usec.to_s

		pad = 16 - timestamp.length

		pad.times do
			timestamp += "0"
		end

		file_name = timestamp + "." + Picture.get_extension(image.content_type, image.original_filename)

		path = File.join("public/images/uploads", file_name)

		File.open(path, "wb") { |f| f.write(image.read) }

		img = Magick::Image.read(path).first

		if img.columns > thumbnail_width or img.rows > thumbnail_height
			thumb = img.resize_to_fit(thumbnail_width, thumbnail_height)
		else
			thumb = img
		end

		thumb_file_name = "t" + file_name

		thumb_path = File.join("public/images/uploads/thumbnails", thumb_file_name)

		thumb.write thumb_path

		return file_name, thumb_file_name
	end

	def self.delete_image_from_disk(file_path)
		if !file_path.blank?
			if File.exist?(file_path)
				begin
					File.delete(file_path)
				rescue Exception => error
					return false, error.message
				end
			end
		end

		return true, nil
	end

	def self.create_from_remote(uri)
		image_uri = URI.parse(URI.encode(uri))

		image_file_name = File.basename(image_uri.path)

		image_file = nil

		begin
			timeout(15) do
				Net::HTTP.start(image_uri.host, image_uri.port) do |http|
					response = http.get(image_uri.path)

					image_file = ActionController::UploadedTempfile.new(image_file_name)

					image_file.binmode

					image_file.write(response.body)

					image_file.original_path = image_file_name

					case image_file.original_path.split(".").last.downcase
						when "gif"
							image_file.content_type = "image/gif"
						when "jpg", "jpeg"
							image_file.content_type = "image/jpeg"
						when "png"
							image_file.content_type = "image/png"
						when "svg"
							image_file.content_type = "image/svg+xml"
						when "tif", "tiff"
							image_file.content_type = "image/tiff"
						else
							image_file.content_type = "other"
					end

					image_file.rewind
				end
			end
		rescue TimeoutError
			raise "Connection to #{image_uri.host} timed out."
		end

		picture = Picture.new

		picture.original_filename = image_file.original_path

		picture.title = image_file.original_path

		picture.caption = image_file.original_path

		picture.alt_text = image_file.original_path

		picture.max_thumbnail_width = 100

		picture.max_thumbnail_height = 100

		result, message = picture.save_image(image_file)

		picture.save

		return picture
	end
end
