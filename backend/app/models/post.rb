class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many_attached :videos

  validate :description_or_attachment_present
  validate :correct_image_type
  validate :correct_video_type

  private

  def description_or_attachment_present
    if description.blank? && images.blank? && videos.blank?
      errors.add(:base, "Either a description must be written or an image or video must be attached.")
    end
  end

  def correct_image_type
    images.each do |image|
      Rails.logger.debug "Checking image: #{image.filename} with content type: #{image.content_type}"
      # unless image.content_type.in?(%w[image/png image/jpeg image/jpg]) || File.extname(image.filename.to_s).in?(%w[.png .jpg .jpeg])
      unless File.extname(image.filename.to_s).in?(%w[.png .jpg .jpeg])
        errors.add(:images, "must be jpg, jpeg or png")
      end
    end
  end

  def correct_video_type
    videos.each do |video|
      Rails.logger.debug "Checking video: #{video.filename} with content type: #{video.content_type}"
      # unless video.content_type.in?(%w[video/mp4 video/mpeg video/quicktime])
      unless File.extname(video.filename.to_s).in?(%w[.mp4 .mpeg .mov])
        errors.add(:videos, "must be an mp4, mpeg or quicktime video")
      end
    end
  end

end