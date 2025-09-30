class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one_attached :video

  validate :acceptable_video

  def acceptable_video
    return unless video.attached?

    unless video.byte_size <= 50.megabytes
      errors.add(:video, "is too large (max 50 MB)")
    end

    acceptable_types = ["video/mp4", "video/webm"]
    unless acceptable_types.include?(video.content_type)
      errors.add(:video, "must be an MP4 or WebM")
    end
  end
end
