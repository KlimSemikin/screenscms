class ContentUploader < CarrierWave::Uploader::Base
  storage :aws

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png mp4 avi mpeg mpg wmv html vid webm aac mp3 wav ogg wave)
  end
end
