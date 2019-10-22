  class Micropost < ApplicationRecord
  belongs_to :user

  scope :newpost, -> { order created_at: :desc }
  scope :by_user_ids, ->(user_ids) {where user_id: user_ids}

  delegate :name, to: :user, prefix: true

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.validation_micropost.validation_content }
  validate  :picture_size

  private
    def picture_size
      return if picture.size < Settings.validation_micropost.limit_size_img.megabytes
      errors.add :picture, t("microposts_show_user.tittle_microposts_show10")
    end
end
