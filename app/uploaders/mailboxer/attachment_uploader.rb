class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base 
  include CarrierWave::RMagick

	storage :fog
	
	version :thumb do 
		process resize_to_fill: [200, 200]
	end 
	
end 
