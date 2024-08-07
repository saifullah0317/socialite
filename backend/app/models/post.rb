class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :video

  # validates :description, presence: true
  validate :description_or_attachment_present

  def description_or_attachment_present
    if description.blank? && !image.attached? && !video.attached?
      errors.add(:base, "Either and image or video must be attached.")
    end
  end
end