require "digest/sha2"

class AgentResource < ActiveRecord::Base
	belongs_to :person

	has_one :picture, :as => :attachable

	def before_destroy
		result, message = self.delete_file

		if result != true
			raise message
		end

		return result
	end

	def save_file(file)
		if file.class == ActionController::UploadedTempfile or file.class == Tempfile or file.class == ActionController::UploadedStringIO
			if file.size != 0
				result, message = AgentResource.validate_file_content_type(file)

				if result != true
					return false, message
				end

				self.sha2_checksum = AgentResource.calculate_checksum(file)

				agent_resources = AgentResource.find_by_sha2_checksum(self.sha2_checksum)

				if !agent_resources.nil?
					return false, "Error: Duplicate file uploaded!"
				end

				result, message = self.delete_file

				if result != true
					return false, message
				end

				self.resource_filename = AgentResource.write_file_to_disk(file)

				self.original_filename = file.original_filename

				self.extension = self.original_filename.split(".").last.downcase
			else
				return false, "Error: 0 length file."
			end
		else
			return false, "Error: Invalid data type uploaded."
		end

		return true, nil
	end

	def delete_file
		if !self.resource_filename.nil?
			result, message = AgentResource.delete_file_from_disk(File.join("private/uploads", self.resource_filename))

			if result != true
				return false, message
			end

			self.resource_filename = nil
		end

		return true, nil
	end

	def self.validate_file_content_type(file)
		if !file.nil?
			if file.size != 0
				extension = file.original_filename.split(".").last.downcase

				if extension == "exe" or extension == "msi" or extension == "com" or extension == "dll" or extension == "bat" or extension == "jar"
					return false, "Error: Invalid file type."
				end

				#if file.content_type == "application/octet-stream"
					#return false, "Error: Invalid file type."
				#end

				#add in other disallowed file types here later

				#if image.content_type != "image/gif" and image.content_type != "image/jpeg" and image.content_type != "image/png" and image.content_type != "image/svg+xml" and image.content_type != "image/tiff"
					#return false, "Error: Invalid file type. Only GIF, JPEG, PNG, SVG, and TIFF are supported."
				#end
			else
				return false, "Error: 0 length file."
			end
		else
			return false, "Error: null file."
		end

		return true, nil
	end

	def self.calculate_checksum(file)
		file_data = file.read

		file.rewind

		return Digest::SHA256.hexdigest(file_data)
	end

	def self.write_file_to_disk(file)
		timestamp = Time.now.to_i.to_s + Time.now.usec.to_s

		pad = 16 - timestamp.length

		pad.times do
			timestamp += "0"
		end

		file_name = timestamp + "_" + file.original_filename

		path = File.join("private/uploads", file_name)

		File.open(path, "wb") { |f| f.write(file.read) }

		return file_name
	end

	def self.delete_file_from_disk(file_path)
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
end
